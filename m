From: qzhang <qin.2.zhang@nsn.com>
Date: Wed, 25 Jan 2017 12:25:25 +0800
Subject: [PATCH] Fixed the mips 64bits checksum error -- csum_tcpudp_nofold
Message-ID: <20170125042525.kXtTIJXvu8_SRkn914BPzsjsHf_jOYq3dFMG1eA4iN0@z>

---
 arch/mips/include/asm/checksum.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 7749daf..0e351c5 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -184,6 +184,10 @@ static inline __wsum csum_tcpudp_nofold(__be32
saddr, __be32 daddr,
  " daddu %0, %2 \n"
  " daddu %0, %3 \n"
  " daddu %0, %4 \n"
+ " dsrl32  $1, %0, 0 \n"
+ " dsll32 %0, %0, 0 \n"
+ " dsrl32 %0, %0, 0 \n"
+ " daddu   %0, $1 \n"
  " dsll32 $1, %0, 0 \n"
  " daddu %0, $1 \n"
  " dsra32 %0, %0, 0 \n"

I agree there does appear to be a bug in the code, and my
understanding of MIPS assembly is limited, but I don't think your
patch truly fixes it.  From what I can understand it seems like you
would just be shifting the register called out at %0 past 64 bits
which would just zero it out.

Below is the snippet you are updating:

    #ifdef CONFIG_64BIT
            "       daddu   %0, %2          \n"
            "       daddu   %0, %3          \n"
            "       daddu   %0, %4          \n"
            "       dsll32  $1, %0, 0       \n"
            "       daddu   %0, $1          \n"
            "       dsra32  %0, %0, 0       \n"
    #endif

From what I can tell the issue is that the dsll32 really needs to be
replaced with some sort of rotation type call instead of a shift, but
it looks like MIPS doesn't have a rotation instruction.  We need to
add the combination of a shift left by 32, to a shift right 32, and
then add that value back to the original register.  Then we will get
the correct result in the upper 32 bits.

I'm not even sure it is necessary to use inline assembler.  You could
probably just use the inline assembler for the 32b and change the 64b
approach over to using C.  The code for it would be pretty simple:
    unsigned long res = (__force unsigned long)sum;

    res += (__force unsigned long)daddr;
    res += (__force unsigned long)saddr;
#ifdef __MIPSEL__
    res += (proto + len) << 8;
#else
    res += proto + len;
#endif
    res += (res << 32) | (res >> 32);

    return (__force __wsum)(res >> 32);

That would probably be enough to fix the issue and odds are it should
generate assembly code very similar to what was already there.

- Alex

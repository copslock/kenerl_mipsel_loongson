Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 02:32:35 +0000 (GMT)
Received: from eta.ghs.com ([IPv6:::ffff:63.102.70.66]:43007 "EHLO eta.ghs.com")
	by linux-mips.org with ESMTP id <S8225581AbUAVCcf>;
	Thu, 22 Jan 2004 02:32:35 +0000
Received: from blaze.ghs.com (blaze.ghs.com [192.67.158.233])
	by eta.ghs.com (8.12.10/8.12.10) with ESMTP id i0M2WOh5019175;
	Wed, 21 Jan 2004 18:32:25 -0800 (PST)
Received: from zcar.ghs.com (zcar.ghs.com [192.67.158.60])
	by blaze.ghs.com (8.12.9/8.12.9) with ESMTP id i0M2WNBe021044;
	Wed, 21 Jan 2004 18:32:23 -0800 (PST)
Date: Wed, 21 Jan 2004 18:32:23 -0800 (PST)
From: Nathan Field <ndf@ghs.com>
To: Kumba <kumba@gentoo.org>
cc: linux-mips@linux-mips.org
Subject: Solving the cross-compiler issue (Was: Trouble compiling MIPS
 cross-compiler)
In-Reply-To: <400A1B5F.6010307@gentoo.org>
Message-ID: <Pine.LNX.4.44.0401211633240.31973-101000@zcar.ghs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1136671902-1409114875-1074738743=:31973"
Return-Path: <ndf@ghs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ndf@ghs.com
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1136671902-1409114875-1074738743=:31973
Content-Type: TEXT/PLAIN; charset=US-ASCII

This email is a bit long so here's the short version:
	Building cross tools is basically impossible without knowledge 
which isn't available on the www.linux-mips.org web site
	glibc seems to have obvious syntax errors and won't even compile
	The prebuilt tools referenced in the FAQ are so out of date 
they're useless
	Even tools provided by various commercial Linux vendors are out of 
date (at least what MontaVista lets us see in their preview kits)
	This could all be solved if someone wrote a script to do all the 
work which contains all the logic necessary to get a known set of tools to 
build

I've written a script which will do all the work, but because there are 
failures in building glibc it doesn't work. If someone could help me get 
my script to work it could be used to update the cross compile section of 
the FAQ. The script as it stands is attached. It needs some configuration 
(which is why it exits by default), but if you're trying to build a cross 
compiler you'd better have at least some knowledge of what you're doing.

Here's what it does:
	it wgets specific versions of binutils, gcc and glibc
	it sets some environment variables
	it uncompresses and builds the tools in the "correct" sequence 
with the correct options

There are 2 problems with this script:
	1. It references a specific binutils snapshot which will probably 
go away in a few days
	2. It doesn't f'ing work

That said, here's where things are breaking:

I'm also trying to build a newer cross toolchain since MontaVista doesn't
seem to provide one recent enough to even build the linux_2_4 branch from
the linux-mips cvs repository (it builds, but when I run it on my Malta
board it crashes immediately). I'm coming up against problems that just
seem stupidly obvious... Enough ranting though, here are the details.

Kumba suggested using:
> I'd recommend the following:
> binutils-2.14.90.0.7 (or you can try the latest .8 release, it has some 
> more mips fixes in it)
> glibc-2.3.2 (or 2.3.1)
> gcc-3.3.2
	I couldn't find a version of binutils like that, so I grabbed 
yesterdays snapshot, which builds and runs fine. Then I built the gcc 
bootstrap fine. Then I tried building glibc-2.3.2. That failed when it got 
to stdio-common/sscanf. The declaration of sscanf:

sscanf (s, format)
     const char *s;
     const char *format;

Doesn't match the function, and it should be:

sscanf (const char *s, const char *format, ...)

Does no one even bother to test to see if these things compile before they 
are released? I've had similar syntax error type problems when building 
several older (2.2.x) versions of glibc for PPC.

Anyway, after I fixed that I now get a link failure:

/space1/ndf/linux/mips/tools/glibc-build/elf/ld.so.1: undefined reference 
to `elf_machine_rela.7'

The command which generates this is:

mips-linux-gcc -nostdlib -nostartfiles -o 
/space1/ndf/linux/mips/tools/glibc-build/iconv/iconvconfig  
-Wl,-dynamic-linker=/space1/ndf/demos/malta_linux_reference/embedded/tools/lib/ld.so.1    
/space1/ndf/linux/mips/tools/glibc-build/csu/crt1.o 
/space1/ndf/linux/mips/tools/glibc-build/csu/crti.o `mips-linux-gcc 
--print-file-name=crtbegin.o` 
/space1/ndf/linux/mips/tools/glibc-build/iconv/iconvconfig.o 
/space1/ndf/linux/mips/tools/glibc-build/iconv/strtab.o 
/space1/ndf/linux/mips/tools/glibc-build/iconv/xmalloc.o  
-Wl,-rpath-link=/space1/ndf/linux/mips/tools/glibc-build:/space1/ndf/linux/mips/tools/glibc-build/math:/space1/ndf/linux/mips/tools/glibc-build/elf:/space1/ndf/linux/mips/tools/glibc-build/dlfcn:/space1/ndf/linux/mips/tools/glibc-build/nss:/space1/ndf/linux/mips/tools/glibc-build/nis:/space1/ndf/linux/mips/tools/glibc-build/rt:/space1/ndf/linux/mips/tools/glibc-build/resolv:/space1/ndf/linux/mips/tools/glibc-build/crypt:/space1/ndf/linux/mips/tools/glibc-build/linuxthreads 
/space1/ndf/linux/mips/tools/glibc-build/libc.so.6 
/space1/ndf/linux/mips/tools/glibc-build/libc_nonshared.a -lgcc 
`mips-linux-gcc --print-file-name=crtend.o` 
/space1/ndf/linux/mips/tools/glibc-build/csu/crtn.o
/space1/ndf/linux/mips/tools/glibc-build/elf/ld.so.1: undefined reference 
to `elf_machine_rela.7'

Interestingly when I try glibc 2.3.1 I get the same syntax error in sscanf 
but the linker complains about elf_machine_rela, without the .7.

It would be wonderful if I could get some help on this. It seems like a
chicken and egg problem which will only get worse as more and more people
try to build the 2.6 kernels.

	nathan

PS. This script is totally ripped off of Kumba's script which he submitted 
earlier. I've just added stuff to try to automate *everything*.

-- 
Nathan Field (ndf@ghs.com)			          All gone.

But the trouble with analogies is that analogies are like goldfish:
sometimes they have nothing to do with the topic at hand.
        -- Crispin (from a posting to the Bugtraq mailing list)


--1136671902-1409114875-1074738743=:31973
Content-Type: APPLICATION/x-sh; name="build_tools.sh"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0401211832230.31973@zcar.ghs.com>
Content-Description: 
Content-Disposition: attachment; filename="build_tools.sh"

IyEvYmluL3NoCgojIFRoaXMgc2NyaXB0IGlzIGJhc2VkIG9uIGEgc2NyaXB0
IHBvc3RlZCB0byBsaW51eC1taXBzQGxpbnV4LW1pcHMub3JnCiMgYnkgS3Vt
YmEgPGt1bWJhQGdlbnRvby5vcmc+LiBJdCBpcyBpbnRlbmRlZCB0byBjb250
YWluIGFsbCBsb2dpYwojIG5lY2Vzc2FyeSB0byBidWlsZCBhIExpbnV4IE1J
UFMgdG9vbGNoYWluLiBUaGlzIHNlZW1zIHRvIGJlIGEgdmVyeQojIGNvbW1v
biBpc3N1ZSBvbiB0aGUgbWFpbGluZyBsaXN0LgoKZWNobyAiWW91IG11c3Qg
Zmlyc3Qgc2V0dXAgdGhlIGVudmlyb25tZW50IHZhcmlhYmxlcyBmb3IgeW91
ciBjb25maWd1cmF0aW9uLiIKZXhpdCAxCgpleHBvcnQgbXlBUkNIPW1pcHMt
bGludXgKZXhwb3J0IG15SE9TVD1pMzg2LWxpbnV4CmV4cG9ydCBteURFU1Q9
L3NwYWNlMS9uZGYvZGVtb3MvbWFsdGFfbGludXhfcmVmZXJlbmNlL2VtYmVk
ZGVkL3Rvb2xzCmV4cG9ydCBteVhUUkE9Ii1taXBzMiIKZXhwb3J0IG15T1JJ
R0hFQURFUlM9L2hvbWUvemNhcjEvbmRmL2RlbW9zL21hbHRhX2xpbnV4X3Jl
ZmVyZW5jZS9lbWJlZGRlZC9uZnNyb290X2ZpbGVzeXN0ZW0vdXNyL2luY2x1
ZGUKZXhwb3J0IG15S0VSTkVMU1JDPS9ob21lL3pjYXIxL25kZi9kZW1vcy9t
YWx0YV9saW51eF9yZWZlcmVuY2UvZW1iZWRkZWQvbGludXgtMi40LjE3X212
bDIxCmV4cG9ydCBQQVRIPSR7bXlERVNUfS9iaW46JFBBVEgKCgojIE5laXRo
ZXIgdmVyc2lvbiB3b3JrcywgYnV0IHlvdSBjYW4gdHJ5IGVpdGhlciBpZiB5
b3Ugd2FudC4KI2V4cG9ydCBHTElCQ19WRVI9Mi4zLjEKZXhwb3J0IEdMSUJD
X1ZFUj0yLjMuMgoKCmlmIFsgISAtZiBzc2NhbmYuY19maXhlZCBdOyB0aGVu
CiAgIyBUaGUgZGVjbGFyYXRpb24gb2Ygc3NjYW5mIGlzIHdyb25nLCBjaGFu
Z2UgaXQgdG86CiAgIyBpbnQgc3NjYW5mIChjb25zdCBjaGFyICpzLCBjb25z
dCBjaGFyICpmb3JtYXQsIC4uLikKICAjIGFuZCBwdXQgaW50byBhIGZpbGUg
c3NjYW5mLmNfZml4ZWQgaW4gdGhlIHRvcGxldmVsIGRpcmVjdG9yeS4KICBl
Y2hvICJZb3UgbXVzdCBzdXBwbHkgYSBmaXhlZCB2ZXJzaW9uIG9mIHRoZSBz
c2NhbmYuYyBmaWxlIGZvciBnbGliYyIKICBlY2hvICJpbiBnbGliYy0ke0dM
SUJDX1ZFUn0vc3RkaW8tY29tbW9uLiIKICBleGl0IDEKZmkKCgplY2hvICJc
blxuXG4qKioqIERPV05MT0FESU5HIFNPVVJDRSAqKioqXG5cblxuXG4iCmlm
IFsgISAtZiBiaW51dGlscy0wNDAxMjEudGFyLmJ6MiBdOyB0aGVuCiAgd2dl
dCBmdHA6Ly9zb3VyY2VzLnJlZGhhdC5jb20vcHViL2JpbnV0aWxzL3NuYXBz
aG90cy9iaW51dGlscy0wNDAxMjEudGFyLmJ6MgpmaQppZiBbICEgLWYgZ2Nj
LTMuMy4yLnRhci5neiBdOyB0aGVuCiAgd2dldCBmdHA6Ly9mdHAuZ251Lm9y
Zy9nbnUvZ2NjLTMuMy4yLnRhci5negpmaQppZiBbICEgLWYgZ2xpYmMtJHtH
TElCQ19WRVJ9LnRhci5neiBdOyB0aGVuCiAgd2dldCBmdHA6Ly9mdHAuZ251
Lm9yZy9nbnUvZ2xpYmMvZ2xpYmMtJHtHTElCQ19WRVJ9LnRhci5negpmaQpp
ZiBbICEgLWYgZ2xpYmMtbGludXh0aHJlYWRzLSR7R0xJQkNfVkVSfS50YXIu
Z3ogXTsgdGhlbgogIHdnZXQgZnRwOi8vZnRwLmdudS5vcmcvZ251L2dsaWJj
L2dsaWJjLWxpbnV4dGhyZWFkcy0ke0dMSUJDX1ZFUn0udGFyLmd6CmZpCgoK
ZWNobyAiXG5cblxuKioqKiAgTUFLSU5HIEJJTlVUSUxTICoqKipcblxuXG5c
biIKcm0gLXJmIGJpbnV0aWxzLTA0MDEyMQp0YXIgeGpmIGJpbnV0aWxzLTA0
MDEyMS50YXIuYnoyCmNkIGJpbnV0aWxzLTA0MDEyMQouL2NvbmZpZ3VyZSBc
CiAgICAgICAgLS10YXJnZXQ9JHtteUFSQ0h9IC0taG9zdD0ke215SE9TVH0g
XAogICAgICAgIC0tcHJlZml4PSR7bXlERVNUfSAtLWVuYWJsZS1zaGFyZWQg
XAogICAgICAgIC0tZW5hYmxlLTY0LWJpdC1iZmQgXAomJiBtYWtlICYmIG1h
a2UgaW5zdGFsbApjZCAuLgoKCmVjaG8gIlxuXG5cbioqKiogU0VUVElORyBV
UCBLRVJORUwgSEVBREVSUyAqKioqXG5cblxuXG4iCmNwIC1yICR7bXlPUklH
SEVBREVSU30vKiAke215REVTVH0vaW5jbHVkZS8Kcm0gLVJmICR7bXlERVNU
fS9pbmNsdWRlL2xpbnV4CnJtIC1SZiAke215REVTVH0vaW5jbHVkZS9hc20q
CmNwIC1yICR7bXlLRVJORUxTUkN9L2luY2x1ZGUvbGludXggJHtteURFU1R9
L2luY2x1ZGUKY3AgLXIgJHtteUtFUk5FTFNSQ30vaW5jbHVkZS9hc20tJChl
Y2hvICR7bXlBUkNIfSB8IGN1dCAtZC0gLWYxKSAke215REVTVH0vaW5jbHVk
ZQpjcCAtciAke215S0VSTkVMU1JDfS9pbmNsdWRlL2FzbS1nZW5lcmljICR7
bXlERVNUfS9pbmNsdWRlCmxuIC1zICR7bXlERVNUfS9pbmNsdWRlL2FzbS0k
KGVjaG8gJHtteUFSQ0h9IHwgY3V0IC1kLSAtZjEpICR7bXlERVNUfS9pbmNs
dWRlL2FzbSAKCgplY2hvICJcblxuXG4qKioqIERPSU5HIEdDQyBCT09UU1RS
QVAgKioqKlxuXG5cblxuIgppZiBbICEgLWQgZ2NjLTMuMy4yIF07IHRoZW4K
ICB0YXIgeHpmIGdjYy0zLjMuMi50YXIuZ3oKZmkKcm0gLXJmIGdjYy1idWls
ZC1ib290c3RyYXAKbWtkaXIgZ2NjLWJ1aWxkLWJvb3RzdHJhcApjZCBnY2Mt
YnVpbGQtYm9vdHN0cmFwCnRpbWUgLi4vZ2NjLTMuMy4yL2NvbmZpZ3VyZSBc
CiAgICAgICAgLS1wcmVmaXg9JHtteURFU1R9IC0taG9zdD0ke215SE9TVH0g
XAogICAgICAgIC0tdGFyZ2V0PSR7bXlBUkNIfSAtLXdpdGgtbmV3bGliIFwK
ICAgICAgICAtLWRpc2FibGUtc2hhcmVkIC0tZGlzYWJsZS10aHJlYWRzIFwK
ICAgICAgICAtLWVuYWJsZS1sYW5ndWFnZXM9YyAtLWRpc2FibGUtbXVsdGls
aWIgXAogICAgICAgIC0td2l0aG91dC1oZWFkZXJzIFwKJiYgbWFrZSAmJiBt
YWtlIGluc3RhbGwKY2QgLi4KCgplY2hvICJcblxuXG4qKioqIEJVSUxESU5H
IEdMSUJDICoqKipcblxuXG5cbiIKaWYgWyAhIC1kIGdsaWJjLSR7R0xJQkNf
VkVSfSBdOyB0aGVuCiAgdGFyIHh6ZiBnbGliYy0ke0dMSUJDX1ZFUn0udGFy
Lmd6CiAgZWNobyAiUGF0Y2hpbmcgYnJva2VuIHNzY2FuZi5jLiIKICBjcCBz
c2NhbmYuY19maXhlZCBnbGliYy0ke0dMSUJDX1ZFUn0vc3RkaW8tY29tbW9u
L3NzY2FuZi5jCmZpCmlmIFsgISAtZCBnbGliYy0ke0dMSUJDX1ZFUn0vbGlu
dXh0aHJlYWRzIF07IHRoZW4KICBjZCBnbGliYy0ke0dMSUJDX1ZFUn0KICB0
YXIgeHpmIC4uL2dsaWJjLWxpbnV4dGhyZWFkcy0ke0dMSUJDX1ZFUn0udGFy
Lmd6CiAgY2QgLi4KZmkKcm0gLXJmIGdsaWJjLWJ1aWxkCm1rZGlyIGdsaWJj
LWJ1aWxkCmNkIGdsaWJjLWJ1aWxkCnRpbWUgQ0M9IiR7bXlBUkNIfS1nY2Mi
IENGTEFHUz0iLU8yICR7bXlYVFJBfSIgQVM9IiR7bXlBUkNIfS1hcyIgXAoJ
TEQ9IiR7bXlBUkNIfS1sZCIgXAogICAgICAgIC4uL2dsaWJjLSR7R0xJQkNf
VkVSfS9jb25maWd1cmUgXAogICAgICAgICAgICAgICAgLS1wcmVmaXg9JHtt
eURFU1R9IC0taG9zdD0ke215QVJDSH0gXAogICAgICAgICAgICAgICAgLS1i
dWlsZD0ke215SE9TVH0gLS13aXRob3V0LXRscyBcCiAgICAgICAgICAgICAg
ICAtLXdpdGhvdXQtX190aHJlYWQgXAogICAgICAgICAgICAgICAgLS1lbmFi
bGUtYWRkLW9ucz1saW51eHRocmVhZHMgXAogICAgICAgICAgICAgICAgLS1l
bmFibGUta2VybmVsPTIuNC4wIC0td2l0aC1nZD1ubyBcCiAgICAgICAgICAg
ICAgICAtLXdpdGhvdXQtY3ZzIC0tZGlzYWJsZS1wcm9maWxlIFwKICAgICAg
ICAgICAgICAgIC0td2l0aC1oZWFkZXJzPSIke215REVTVH0vaW5jbHVkZSIg
XAogICAgICAgICYmIG1ha2UgJiYgbWFrZSBpbnN0YWxsCmNkIC4uCgoKIyBU
aGlzIGhhcyBub3QgYmVlbiB0ZXN0ZWQgYmVjYXVzZSB0aGUgZ2xpYmMgYnVp
bGQgZmFpbHMuCiNlY2hvICJcblxuXG4qKioqIEJVSUxESU5HIEZVTEwgR0ND
ICoqKipcblxuXG5cbiIKI3JtIC1yZiBnY2MtYnVpbGQtZnVsbAojbWtkaXIg
Z2NjLWJ1aWxkLWZ1bGwKI2NkIGdjYy1idWlsZC1mdWxsCiN0aW1lIC4uL2dj
Yy0zLjMuMi9jb25maWd1cmUgXAojICAgICAgICAtLXByZWZpeD0ke215REVT
VH0gLS10YXJnZXQ9JHtteUFSQ0h9IFwKIyAgICAgICAgLS1ob3N0PSR7bXlI
T1NUfSAtLWRpc2FibGUtbXVsdGlsaWIgXAojICAgICAgICAtLWVuYWJsZS1z
aGFyZWQgLS1lbmFibGUtbGFuZ3VhZ2VzPSJjLGMrKyxhZGEsZjc3LG9iamMi
IFwKIyAgICAgICAgLS1lbmFibGUtbmxzIC0td2l0aG91dC1pbmNsdWRlZC1n
ZXR0ZXh0IFwKIyAgICAgICAgLS13aXRoLXN5c3RlbS16bGliIC0tZW5hYmxl
LXRocmVhZHM9cG9zaXggXAojICAgICAgICAtLWVuYWJsZS1sb25nLWxvbmcg
LS1kaXNhYmxlLWNoZWNraW5nIFwKIyAgICAgICAgLS1lbmFibGUtY3N0ZGlv
PXN0ZGlvIFwKIyAgICAgICAgLS1lbmFibGUtY2xvY2FsZT1nZW5lcmljIFwK
IyAgICAgICAgLS1lbmFibGUtX19jeGFfYXRleGl0IFwKIyAgICAgICAgLS1l
bmFibGUtdmVyc2lvbi1zcGVjaWZpYy1ydW50aW1lLWxpYnMgXAojICAgICAg
ICAtLXdpdGgtbG9jYWwtcHJlZml4PSR7cHJlZml4fS9sb2NhbCBcCiMgICAg
ICAgIC0td2l0aC1saWJzPSIke215REVTVH0vbGliIiBcCiMgICAgICAgIC0t
d2l0aC1oZWFkZXJzPSIke215REVTVH0vJHtteUFSQ0h9L2luY2x1ZGUiIFwK
IyYmIG1ha2UgJiYgbWFrZSBpbnN0YWxsCiNjZCAuLgo=
--1136671902-1409114875-1074738743=:31973--

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARI0hU26603
	for linux-mips-outgoing; Tue, 27 Nov 2001 10:00:43 -0800
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARI0ao26600
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 10:00:36 -0800
Received: from js by hell with local (Exim 3.33 #1 (Debian))
	id 168lao-0001oT-00; Tue, 27 Nov 2001 18:00:22 +0100
Date: Tue, 27 Nov 2001 18:00:22 +0100
From: Johannes Stezenbach <js@convergence.de>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: The Linux binutils 2.11.92.0.12 is released.
Message-ID: <20011127180022.A6897@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
References: <20011126212859.A17557@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011126212859.A17557@lucon.org>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

On Mon, Nov 26, 2001 at 09:28:59PM -0800, H . J . Lu wrote:
> Please report any bugs related to binutils 2.11.92.0.12 to hjl@lucon.org.

I tried to use binutils-2.11.92.0.12 with gcc-3.0.2 to compile
the linux kernel from linux-mips.sourceforge.net for a VR4121 CPU
(littel endian, target mipsel-linux).

a) The linker chrashes trying to create the object file for the
   embedded initrd ramdisk:

make CFLAGS="-I /home/js/MIPS/kernel/build/linux-2.4.14-mips/include/asm/gcc -D__KERNEL__ -I/home/js/MIPS/kernel/build/linux-2.4.14-mips/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic -mips2 -Wa,-m4100,--trap -pipe " -C  arch/mips/ramdisk
make[1]: Entering directory `/home/js/MIPS/kernel/build/linux-2.4.14-mips/arch/mips/ramdisk'
echo "O_FORMAT:  " elf32-tradlittlemips
O_FORMAT:   elf32-tradlittlemips
mipsel-linux-ld -G 0 -T ld.script -b binary --oformat elf32-tradlittlemips -o ramdisk.o ramdisk.gz
make[1]: *** [ramdisk.o] Segmentation fault
make[1]: *** Deleting file `ramdisk.o'

  The same ramdisk.gz worked with binutils-2.11.92.0.10. The ld.script is:
OUTPUT_ARCH(mips)
SECTIONS
{
  .initrd :
  {
       *(.data)
  }
}



b) I still get the -march vs. -mipsN warings:

mipsel-linux-gcc -I /home/js/MIPS/kernel/build/linux-2.4.14-mips/include/asm/gcc -D__KERNEL__ -I/home/js/MIPS/kernel/build/linux-2.4.14-mips/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic -mips2 -Wa,-m4100,--trap -pipe    -fno-omit-frame-pointer -c -o sched.o sched.c
Assembler messages:
Warning: The -march option is incompatible to -mipsN and therefore ignored.

  I tried to change the CPU options from "-mips2 -Wa,-m4100,--trap" to
  "-Wa,-march=4111,--trap" with binutils-2.11.92.0.10, which silenced the
  warnings and seemed to work, but someone notified me that this might
  cause the compiler to generate wrong code. But I need the VR4111
  suspend/hibernate/standby mnemonics for power management.


Regards,
Johannes

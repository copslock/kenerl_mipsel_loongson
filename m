Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 10:47:48 +0100 (BST)
Received: from smtp-send.myrealbox.com ([IPv6:::ffff:192.108.102.143]:51481
	"EHLO smtp-send.myrealbox.com") by linux-mips.org with ESMTP
	id <S8225278AbTDPJrr> convert rfc822-to-8bit; Wed, 16 Apr 2003 10:47:47 +0100
Received: from yaelgilad [81.218.83.49] by myrealbox.com
	with NetMail ModWeb Module; Wed, 16 Apr 2003 09:47:45 +0000
Subject: Crash on insmod
From: "Gilad Benjamini" <yaelgilad@myrealbox.com>
To: kernelnewbies@nl.linux.org, linux-mips@linux-mips.org
Date: Wed, 16 Apr 2003 09:47:45 +0000
X-Mailer: NetMail ModWeb Module
X-Sender: yaelgilad
MIME-Version: 1.0
Message-ID: <1050486465.a013bc00yaelgilad@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <yaelgilad@myrealbox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yaelgilad@myrealbox.com
Precedence: bulk
X-list: linux-mips

Hi,
I have a simple scenario, with a simple-cut-down module
which crashes very frequently.

mips-linux 2.4.20 32 bit with 64-bit phys addresses enabled.

- Start the kernel
- insmod (full path, or short-name-after-depmod)
- Crash.

Other modules show no problems.

After much work, the module is now shrunk down to 
the following
-----------------
#define MODVERSIONS
#include <linux/module.h>
#include <linux/init.h>

int __init CG_init_module( void )
{
  return 0;
}

void __exit CG_cleanup_module( void )
{
}

module_init(CG_init_module);
module_exit(CG_cleanup_module);
-----------------

I am clueless as to the cause of the crash.
Oops info didn't provide anything useful, except a possible hint towards sys_create_module. printk's in this function showed it completed succesfully.

insmod -V shows 2.4.7 - Could that be related ?

Any ideas ?

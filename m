Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 10:31:02 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:22534
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225353AbUAVKbC>; Thu, 22 Jan 2004 10:31:02 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 22 Jan 2004 10:31:51 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i0MAVg1x067812;
	Thu, 22 Jan 2004 19:31:42 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 22 Jan 2004 19:32:27 +0900 (JST)
Message-Id: <20040122.193227.28780052.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: dimitri@sonycom.com, linux-mips@linux-mips.org
Subject: Re: access_ok and CONFIG_MIPS32 for 2.6
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040104210327.GA15475@sonycom.com>
	<20040122024529Z8224936-9616+669@linux-mips.org>
	<20040104.210532.74756709.anemo@mba.ocn.ne.jp>
References: <20040102194403.GB31092@linux-mips.org>
	<20040104.210532.74756709.anemo@mba.ocn.ne.jp>
	<20040104210327.GA15475@sonycom.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sun, 4 Jan 2004 22:03:27 +0100, Dimitri Torfs <dimitri@sonycom.com> said:
>> It seems there should be another definition of USER_DS for
>> CONFIG_MIPS32 in 2.6.

dimitri> Yes, I'm setting USER_DS to 0x80000000 for CONFIG_MIPS32:

Now we can see this fix in CVS 2.6 tree (Thank you, Ralf).

Then, how about this one?

>>>>> On Sun, 04 Jan 2004 21:05:32 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
> Second, __access_ok for 64bit kernel is broken both 2.4 and 2.6.  It
> returns 0 if 'addr' + 'size' == TASK_SIZE (which should be OK).
> 
> 2.4 mips64:
> #define __access_ok(addr, size, mask)					\
> 	(((mask) & ((addr) | ((addr) + (size)) | __ua_size(size))) == 0)
> 2.6:
> #define __access_ok(addr, size, mask)					\
> 	(((signed long)((mask) & ((addr) | ((addr) + (size)) | __ua_size(size)))) == 0)
> 
> I think these macros should be:
> 
> 2.4 mips64:
> #define __access_ok(addr, size, mask)					\
> 	(((mask) & ((addr) | ((addr) + (size) - 1) | __ua_size(size))) == 0)
> 2.6:
> #define __access_ok(addr, size, mask)					\
> 	(((signed long)((mask) & ((addr) | ((addr) + (size) - 1) | __ua_size(size)))) == 0)


For example, currently, access_ok(0xfffffff000UL, 0x1000) will return
0.  This must be legal (and this is a real problem for n64 mount
syscall which may grab user stack.  See copy_mount_option()).

---
Atsushi Nemoto

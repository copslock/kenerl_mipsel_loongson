Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4PJCrnC004392
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 25 May 2002 12:12:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4PJCrkf004391
	for linux-mips-outgoing; Sat, 25 May 2002 12:12:53 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4PJConC004388
	for <linux-mips@oss.sgi.com>; Sat, 25 May 2002 12:12:51 -0700
Received: from localhost.localdomain ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 17Bgz6-0004w0-00; Sat, 25 May 2002 14:13:48 -0500
Message-ID: <3CEFE253.4090107@realitydiluted.com>
Date: Sat, 25 May 2002 14:13:23 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020520 Debian/1.0rc2-3
MIME-Version: 1.0
To: robru <robru@teknuts.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Executing IRIX binary ?
References: <000701c2041f$4d2ae7f0$0a01a8c0@sohotower>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

robru wrote:
> 
> How can I find out if I compiled my kernel with the compatibility code?
> 
I don't mean to be critical, but read the code. If you look in the
'arch/mips/config.in' file you will find:

if [ "$CONFIG_CPU_LITTLE_ENDIAN" = "n" ]; then
    bool 'Include IRIX binary compatibility' CONFIG_BINFMT_IRIX
    bool 'Include forward keyboard' CONFIG_FORWARD_KEYBOARD
fi

at around line #522. You have to be a big endian machine since IRIX is
itself a big endian operating system. This option is under the menu
'General setup'.

-S

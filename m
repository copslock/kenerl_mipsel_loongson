Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 11:33:49 +0100 (BST)
Received: from ali.ali.com.tw ([202.3.177.34]:55187 "HELO ali.ali.com.tw")
	by ftp.linux-mips.org with SMTP id S20038472AbWIYKdq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 25 Sep 2006 11:33:46 +0100
Received: (qmail 18043 invoked by uid 0); 25 Sep 2006 10:33:30 -0000
Received: from william_lei@ali.com.tw by mx.ali.com.tw by uid 502 with qmail-scanner-1.15 
 (iscan: v3.1/v6.810-1005/783/76729.  Clear:. 
 Processed in 0.203787 secs); 25 Sep 2006 10:33:30 -0000
Received: from unknown (HELO TWALINS2) ([202.3.177.54]) (envelope-sender <william_lei@ali.com.tw>)
          by ali.ali.com.tw (qmail-ldap-1.03) with SMTP
          for <kevink@mips.com>; 25 Sep 2006 10:33:29 -0000
In-Reply-To: <001401c6e07e$8b07c080$10eca8c0@grendel>
Subject: Re: How to emulate lw/sw instruction by lb/sb instruction
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	linux-mips@linux-mips.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OFCDEA2C7E.BF7FD296-ON482571F4.0039233C-482571F4.003A3A12@LocalDomain>
From:	william_lei@ali.com.tw
Date:	Mon, 25 Sep 2006 18:35:01 +0800
X-MIMETrack: Serialize by Router on TWALINS2/ALI_TPE/ACER(Release 5.0.11  |July 24, 2002) at
 2006/09/25 06:33:33 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Return-Path: <william_lei@ali.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: william_lei@ali.com.tw
Precedence: bulk
X-list: linux-mips


Dear Kevin
      Because there are some aligned instruction will load/store from/to
unaligned base address in some module,such as "lw t0,56(sp)  ##sp is odd
address"
that's why I want some special version GCC can avoid generating load/store
4 bytes opcode,then I can use this "GCC" to compile specified module and
linked with others,it will avoid unnecessary exception processing when
these instruction to be invoked and come up with best performance for me.
Regards
William Lei


|---------+---------------------------->
|         |           "Kevin D.        |
|         |           Kissell"         |
|         |           <kevink@mips.com>|
|         |                            |
|         |                            |
|         |           2006-09-25 16:42 |
|---------+---------------------------->
  >------------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                              |
  |       To:       <linux-mips@linux-mips.org>, <william_lei@ali.com.tw>                                                        |
  |       cc:                                                                                                                    |
  |       Subject:  Re: How to emulate lw/sw instruction by lb/sb instruction                                                    |
  >------------------------------------------------------------------------------------------------------------------------------|





The MIPS Linux kernel is capable of handling unalgined loads and
stores in emulation.  This is less efficient than synthesizing the word
access out of byte or left/right load/store operations in-line, but it's
only done when there really is an unaligned access, whereas forcing
the compiler to synthesize *all* loads/stores adds that overhead
even when the addresses are actually aligned.

            Regards,

            Kevin K.

----- Original Message -----
From: <william_lei@ali.com.tw>
To: <linux-mips@linux-mips.org>
Sent: Monday, September 25, 2006 2:41 AM
Subject: How to emulate lw/sw instruction by lb/sb instruction


> Dear all
>       Could someone tell me how to modify GCC as titled?because we have
met
> problem while porting some middleware,which will generate some lw/sw
> instruction to unaligned address,so I would modify GCC to not generate
> lw/sw instructions for this pieces code.
> Regards
> William Lei
>
> ************* Email Confidentiality Notice ********************
>
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
conveyed
> only to the designated recipient(s). Any use, dissemination,
distribution,
> printing, retaining or copying of this e-mail (including its attachments)
> by unintended recipient(s) is strictly prohibited and may be unlawful. If
> you are not an intended recipient of this e-mail, or believe that you
have
> received this e-mail in error, please notify the sender immediately (by
> replying to this e-mail), delete any and all copies of this e-mail
> (including any attachments) from your system, and do not disclose the
> content of this e-mail to any other person. Thank you!
>
>
>
>

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2M5NjA07184
	for linux-mips-outgoing; Thu, 21 Mar 2002 21:23:45 -0800
Received: from granite.he.net (granite.he.net [216.218.226.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2M5Ngq07181
	for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 21:23:42 -0800
Received: from w2k30g (209-142-39-228.stk.inreach.net [209.142.39.228]) by granite.he.net (8.8.6/8.8.2) with SMTP id VAA08085 for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 21:26:05 -0800
Message-ID: <001401c1d161$eef48640$0b01a8c0@w2k30g>
From: "David Christensen" <dpchrist@holgerdanske.com>
To: <linux-mips@oss.sgi.com>
Subject: Fw: Fw: Fw: hello
Date: Thu, 21 Mar 2002 21:24:37 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

linux-mips@oss.sgi.com:

Hartvig Ekner <hartvige@mips.com> wrote:
>> What host hardware platform(s) and host operating system(s) does MIPS
>> use to build their MIPS Linux distribution as found on
>> ftp://ftp.mips.com/pub/linux/mips/?
>
> We use commercial Redhat x86/Linux hosts with the cross compiler link
> I sent for kernel compiles. All the binary RPM's are directly from
> H.J.s miniport (which I believe is mostly crosscompiled), and then we
> added some of the nfs/cdrom installation scripts around all this. We
> only rebuild parts of userland (most often native) from the SRPMS when
> necessary for internal debug etc, but this is purely for debug, not
> re-distribution.
>
> All of H.J's binary RPMs for the userland and the corresponding source
> RPMs we used can be found at:
>
> ftp://oss.sgi.com/pub/linux/mips/redhat/7

Great!  Thanks for all the help.  :-)


David

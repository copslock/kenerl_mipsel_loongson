Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8P0jvu05728
	for linux-mips-outgoing; Mon, 24 Sep 2001 17:45:57 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8P0jRD05260
	for <linux-mips@oss.sgi.com>; Mon, 24 Sep 2001 17:45:27 -0700
Message-Id: <200109250045.f8P0jRD05260@oss.sgi.com>
Received: (qmail 18902 invoked from network); 25 Sep 2001 00:39:41 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 25 Sep 2001 00:39:41 -0000
Date: Tue, 25 Sep 2001 8:42:29 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Guido Guenther <agx@debian.org>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: Need an account on a Linux/Mips box
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8P0jSD05267
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,Guido Guenther£¬
   

ÔÚ 2001-09-24 17:54:00 you wrote£º
>On Mon, Sep 24, 2001 at 05:37:23PM +0200, Raoul Borenius wrote:
>> Does it run without any problems? What kernel (with what patches?) are you
>> running. I'm having troubles running our R4600-Indy:
>> 
>> - Perl is seg-faulting (especially when a perl-script is calling another)
>I'm seeing the same here. The gdb output of these segfaults is rather
>weird too(gotta look that one up though). Never found time to look
>deeper into this.
>> 
>> I'm using kernel-image-2.4.5 from debian but we've had these problems
>> all through 2.4.x.
>Hmm...I'm sure that very early 2.4.x kernels worked quiet well on R4600.
I am using IDTRC64474 cpu,which is essentially a R4600.And kernel here
(based on cvs 20010909,2.4.8) works well too(Except for the 8259 problem
I posted days ago).
>One way to hunt the problem down, would be to roll back to 2.4.0 and
>spot the point in cvs where things break.
>Could it be possible that things fail since glibc uses sysmips?
Maybe,if i use 2.4.8 kernel and the binarys of hardhat2.0,ls etc segfaults
while it works well under its 2.4.2hh kernel.
> -- Guido
>
>-- 
>This kind of limitation can lead administrators to do irrational things,
>      like install Windows. Clearly a fix was required. (lwn.net)

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn

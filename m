Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f842RJp07648
	for linux-mips-outgoing; Mon, 3 Sep 2001 19:27:19 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f842RFd07645
	for <linux-mips@oss.sgi.com>; Mon, 3 Sep 2001 19:27:15 -0700
Message-Id: <200109040227.f842RFd07645@oss.sgi.com>
Received: (qmail 30013 invoked from network); 4 Sep 2001 02:22:04 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 4 Sep 2001 02:22:04 -0000
Date: Tue, 4 Sep 2001 10:29:5 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: kernel test & benchmark tools?
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f842RGd07646
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello,
  Yes,I have download many benchmark already.I am mainly curious about how 
you kernel gurus test your developing kernel.For example,when you change a 
substance part of el(mm/scheduler,etc),how can you be sure it is ok?
  Careful thought certainly helps a lot,but there are things too mysterious
for me to thought of:)



2001-09-04 03:18:00£º
>On Tue, Sep 04, 2001 at 01:56:42AM +0800, Fuxin Zhang wrote:
>
>> hello,linux-mips
>>     I have barely finished porting 2.4 kernel to Algorithmics P6032 board.Now I want
>> to make it more stable and run faster,is there any well-known test or benchmark tools used
>> by mips kernel group? There are too many benchmark around,I don't know which is better suit
>> for kernel test. I heard that linus use lmbench?
>
>lmbench is just a microbenchmark which tests certain very specific aspects
>of the system call interface.  Application performance can be very different.
>I suggest to search google or a well sorted ftp server for benchmarks - there
>are many.
>
>  Ralf

Regards
            Fuxin Zhang
            fxzhang@ict.ac.cn

Received:  by oss.sgi.com id <S42284AbQGTAFR>;
	Wed, 19 Jul 2000 17:05:17 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:6408 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42280AbQGTAEw>;
	Wed, 19 Jul 2000 17:04:52 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id QAA24365
	for <linux-mips@oss.sgi.com>; Wed, 19 Jul 2000 16:56:58 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id TAA07339; Wed, 19 Jul 2000 19:56:25 -0300
Date:   Wed, 19 Jul 2000 19:56:25 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
cc:     linux-mips@oss.sgi.com
Subject: Re: Simple Linux/MIPS 0.2b
In-Reply-To: <20000719101346.B7480@chem.unr.edu>
Message-ID: <Pine.SGI.4.10.10007191916250.7274-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On Wed, 19 Jul 2000, Keith M Wesolowski wrote:
> I have successfully
> built the X libs (4.0 + Guido's newport patch) with the toolchain
> included in Simple 0.2b, and have run applications linked against
> them. The entire system was built from the same toolchain.

There is one thing at this point that would really really help.  I need to
establish a reference point and follow someone elses procedures exactly to
determine what the source of my problem is and why some of you are not
seeing this to the extent that I am.  In this way, we can verify whether
or not there is a bonified problem, and if it is with the tools, maybe get
it fixed.

I think the x libs are a good place to start, because I can guarantee that
I'm breaking those, yet you claim to have them working.  I also know that
I can grab someone else's prebuilt and compile against those and get
working apps.  Thus the x libs demonstrate all the "features" of the
problem that I'm encountering.

If you can answer some questions, I can try to parallel what you have
done:

#1  You say you built X using the tool chain for Simple 0.2b.  Does that
mean you compiled it natively on an Indy with what was effectively Simple
0.2b installed?  Or was it cross compiled using the same releases of the
tools?

#2 You say X 4.0.  Can you be more specific?  Was it an official 4.0
tarball on the xfree ftp site?  Pulled from CVS?  Or was it really a
4.0.1?  Basicly, I want the exact same starting sources that you used.

#3 Where can I get Guido's X patch?

#4 What if anything did you add to the host.def or other config files
before doing "make World"?

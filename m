Received:  by oss.sgi.com id <S553761AbQJQObD>;
	Tue, 17 Oct 2000 07:31:03 -0700
Received: from [206.207.108.63] ([206.207.108.63]:29021 "HELO
        ridgerun-lx.ridgerun.cxm") by oss.sgi.com with SMTP
	id <S553756AbQJQOas>; Tue, 17 Oct 2000 07:30:48 -0700
Received: (qmail 8417 invoked from network); 17 Oct 2000 08:30:37 -0600
Received: from skranz-lx.ridgerun.cxm (HELO ridgerun.com) (skranz@192.168.1.15)
  by ridgerun-lx.ridgerun.cxm with SMTP; 17 Oct 2000 08:30:37 -0600
Message-ID: <39EC628D.43431069@ridgerun.com>
Date:   Tue, 17 Oct 2000 08:30:37 -0600
From:   Steve Kranz <skranz@ridgerun.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Nicu Popovici <octavp@isratech.ro>
CC:     linux-mips@oss.sgi.com
Subject: Re: CrossCompiler.
References: <39EC5A4A.DFE3EAD7@isratech.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Try downloading the make-cross... package located at the
following site:

  ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple

The README file pertaining to that package states
the following:

  "This is the "standard" toolchain. It may not be
  perfect, but it at least builds a working kernel and
  some userland packages. It will be updated as major
  bugs are fixed or every 4-6 weeks or so. If you are
  doing development with Simple and/or glibc 2.2, you
  should be using these versions.
  make-cross.sh can be used to build a full cross
  toolchain in one shot."

Steve Kranz
RidgeRun Inc.

=============================

Nicu Popovici wrote:

> Hello you all,
>
>   I am new in this field so if I will make mistakes please be patient
> and I will try to not repeat myself.
>
> So my task is to setup a gcc crosscompiler which will make code for a
> mips machine. The crosscompiler will run on a i686-pc-linux machine. I
> downloaded the latest stuff from oss.sgi.com ( I read the foozbar
> project which was to setup a crosscompiler on a Indy machine also for
> mips ) but I got an error  .
> Something  with signal 11. Can any of you have any ideea of what to do
> to setupsuch a crosscompiler ?
>
> Thanks for all the help that I will get from you .
>
> Regards,
> Nicu

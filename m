Received:  by oss.sgi.com id <S42255AbQJFOxK>;
	Fri, 6 Oct 2000 07:53:10 -0700
Received: from [206.207.108.63] ([206.207.108.63]:47972 "HELO
        ridgerun-lx.ridgerun.cxm") by oss.sgi.com with SMTP
	id <S42248AbQJFOxA>; Fri, 6 Oct 2000 07:53:00 -0700
Received: (qmail 31070 invoked from network); 6 Oct 2000 08:52:49 -0600
Received: from gmcnutt-lx.ridgerun.cxm (HELO ridgerun.com) (gmcnutt@192.168.1.17)
  by ridgerun-lx.ridgerun.cxm with SMTP; 6 Oct 2000 08:52:49 -0600
Message-ID: <39DDE741.4C00811@ridgerun.com>
Date:   Fri, 06 Oct 2000 08:52:49 -0600
From:   Gordon McNutt <gmcnutt@ridgerun.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test5 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: insmod hates RELA?
References: <23467.970840312@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Keith Owens wrote:

> I am guessing that you need -mlong-calls
> for modules.

That was it exactly. Thanks.
--Gordon

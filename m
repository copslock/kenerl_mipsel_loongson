Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id FAA44472; Fri, 15 Aug 1997 05:45:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA05718 for linux-list; Fri, 15 Aug 1997 05:45:24 -0700
Received: from butterfly.johannesburg.sgi.com (butterfly.johannesburg.sgi.com [134.14.196.122]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA05704 for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 05:45:19 -0700
Received: from johannesburg.sgi.com by butterfly.johannesburg.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id FAA15671; Fri, 15 Aug 1997 05:46:51 -0700
Message-ID: <33F44FBA.60321898@johannesburg.sgi.com>
Date: Fri, 15 Aug 1997 15:46:51 +0300
From: "David S. de Beer" <daviddb@johannesburg.sgi.com>
Reply-To: daviddb@johannesburg.sgi.com
Organization: Silicon Graphics
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
CC: Ariel Faigon <ariel@sgi.com>
Subject: Re: linus accessible from within SGI
References: <199708141832.LAA29943@oz.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ariel Faigon wrote:

> In the case of perl it is easy to cross the firewall by simply
> using a proxy. i.e. you don't need to SOCSify you perl since
> the proxy (which is SOCKsified) does the job for you.
>
> Enclosed below is a (http) 'GET' script that uses one possible
> SGI proxy when given the -e option. The method uses is the name
> of the script so you may symlink it to 'HEAD' for example.
>
> --
> Peace, Ariel
>
>


Ariel,

Wow, great :) Do you perhaps have a perl script for ftp as well?

Also, I've looked around for a xftp client that works with socks and can also copy
recursive directories. Is there something like this available?

Thank you kindly.

David

--
      ,   ,
     { \w/ }
      `>!<`
      (/^\)
      '   '

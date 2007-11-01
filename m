Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 15:00:45 +0000 (GMT)
Received: from smtp106.plus.mail.re1.yahoo.com ([69.147.102.69]:18769 "HELO
	smtp106.plus.mail.re1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20026930AbXKAPAg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Nov 2007 15:00:36 +0000
Received: (qmail 10656 invoked from network); 1 Nov 2007 15:00:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-YMail-OSG:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
  b=EBFOrolZBocMn8McaG2ExegTffcjMVjPQ8yBhoOmjp+5S/VW/ezO8OJJDXdTppj3OrFrjZa5YzAtflIQT1lRiexg0WrMZz8Jh40oFrASs6zrzsafCtqaV8VLfNeXToPDnxSQV3lrrmg8kW2o1OSfo2R25PpJ6Lg/sIoYzYgh7xI=  ;
Received: from unknown (HELO ?192.168.254.6?) (jscottkasten@72.185.69.24 with login)
  by smtp106.plus.mail.re1.yahoo.com with SMTP; 1 Nov 2007 15:00:30 -0000
X-YMail-OSG: a_skwBwVM1lDLX9Eiw7mHFe1PhNU6DRh7hVnit2aM9C9pX21nK_b1ex0bIgsfNDPPkUtWwgTWw--
Date:	Thu, 1 Nov 2007 11:00:20 -0400 (EDT)
From:	"J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@pixie.tetracon-eng.net
To:	Hyon Lim <alex@alexlab.net>
cc:	linux-mips@linux-mips.org
Subject: Re: implementation of software suspend on MIPS. (system log)
In-Reply-To: <dd7dc2bc0711010737m7d0d1586w894d5500d1d8500b@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0711011058410.11401@pixie.tetracon-eng.net>
References: <DDAE9570F73FC744918E843E20BE598B096E8E@server1.RightHand.righthandtech.com>
  <dd7dc2bc0710311846ve03e03eued4ed72c89b06e4f@mail.gmail.com> 
 <Pine.SGI.4.60.0710312221360.4697@zeus.tetracon-eng.net> 
 <dd7dc2bc0711010211k530296a4u8dc9272673075248@mail.gmail.com> 
 <Pine.LNX.4.64.0711010908090.11339@pixie.tetracon-eng.net>
 <dd7dc2bc0711010737m7d0d1586w894d5500d1d8500b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <jscottkasten@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscottkasten@yahoo.com
Precedence: bulk
X-list: linux-mips


On Thu, 1 Nov 2007, Hyon Lim wrote:

> Thank you for comments.
> The remain work of my software suspend on MIPS project is resume procedure.
> I already confirmed that suspend function was work. (See my post which
> contains system log).
>
> In an i386 implementation, there are only few assembly code for suspend and
> resume procedure.
> (You can refer :
> http://lxr.linux.no/source/arch/i386/power/swsusp.S?v=2.6.10)
> So, my work will be similar with i386 implementation. Assembly code used in
> i386 implementation are several processor context related job
> and copy saved page to memory. Instruction used in my MIPS implementation
> will be compatible to most of MIPS processor.
> Because the instruction used in implementation is very basic (store and load
> and branch).
>
> I agree your opinion related to maintainability and readability. So I
> implement my work with C and few assembly code.
> Thank you for advice.
>

I look forward to your eventual success. :)

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 13:42:34 +0000 (GMT)
Received: from smtp103.plus.mail.re1.yahoo.com ([69.147.102.66]:33104 "HELO
	smtp103.plus.mail.re1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20026803AbXKANmZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Nov 2007 13:42:25 +0000
Received: (qmail 88324 invoked from network); 1 Nov 2007 13:41:19 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-YMail-OSG:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
  b=A8jJnFsh7nG1N8O5f0OGuPcKVBZsvTnzlDZvaqt/GRzzwARsL3bIwYPloA/zwRI2KnM6Dj4OBYgAXffD1RvyDgDK50jEnXlBa+Jn4uemkAEykwGAk6wXKoG0TAHygqgjyyTIeCasKLOLuYpnblINLsJM44/4hnkJPK21QTLR7iM=  ;
Received: from unknown (HELO ?192.168.254.6?) (jscottkasten@72.185.69.24 with login)
  by smtp103.plus.mail.re1.yahoo.com with SMTP; 1 Nov 2007 13:41:18 -0000
X-YMail-OSG: mjqeyvUVM1mifQm6PmYvxwcYLtr3u3kiVHBc1flwqEOQRYk8dKYh8l6tVWxPL46sheyQPz28Kg--
Date:	Thu, 1 Nov 2007 09:41:12 -0400 (EDT)
From:	"J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@pixie.tetracon-eng.net
To:	Hyon Lim <alex@alexlab.net>
cc:	linux-mips@linux-mips.org
Subject: Re: implementation of software suspend on MIPS. (system log)
In-Reply-To: <dd7dc2bc0711010211k530296a4u8dc9272673075248@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0711010908090.11339@pixie.tetracon-eng.net>
References: <DDAE9570F73FC744918E843E20BE598B096E8E@server1.RightHand.righthandtech.com>
  <dd7dc2bc0710311846ve03e03eued4ed72c89b06e4f@mail.gmail.com> 
 <Pine.SGI.4.60.0710312221360.4697@zeus.tetracon-eng.net>
 <dd7dc2bc0711010211k530296a4u8dc9272673075248@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <jscottkasten@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscottkasten@yahoo.com
Precedence: bulk
X-list: linux-mips



On Thu, 1 Nov 2007, Hyon Lim wrote:

> I think the reason of assembly implementation is processor context
> replacement.

Understood.  Assembly may indeed be required for specific things like 
restoring register state or fiddling with the cache if there aren't 
already macros or functions in the kernel that do exactly what you need.

> The second reason that I thinking is calling convention of C language.

It's not uncommon at all to have assembly language glue, say between a 
BIOS callback and the C language routine that does the work.

In your original post, you mentioned tracking variables and things that 
suggested a module that does much more that just load some odd registers 
or flip around a function call stack.  If that is indeed the case, then 
for sake of maintainablility and readability, one would be strongly 
encouraged to write the core stuff in plain old C and sprinkle in assembly 
glue code as required.

Think about it this way.  MIPS is a pretty large family of CPUs, each with 
it's own strange behaviors.  Several of those people on this list spend a 
lot of time tweeking that assembly to make it work cleanly across various 
CPUs.  It's a lot easier to understand 25 lines of assembly interface code 
and 200 lines of C code, than an entire 1000 line module written in 
assembly.  It's also a lot easier when you can shove most of the work over 
to the compiler, especially if others like your work and want to 
generalize it for use on many other MIPS CPUs.

I guess the real question here is how complex do you think your code needs 
to be?  That should determine your path.

Regards,

-S-

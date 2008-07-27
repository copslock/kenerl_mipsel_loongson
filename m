Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jul 2008 22:37:09 +0100 (BST)
Received: from mail.codesourcery.com ([65.74.133.4]:11468 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S20023289AbYG0VhB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 27 Jul 2008 22:37:01 +0100
Received: (qmail 26189 invoked from network); 27 Jul 2008 21:36:58 -0000
Received: from unknown (HELO ?192.168.0.3?) (mitchell@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 27 Jul 2008 21:36:58 -0000
Message-ID: <488CEA74.4060505@codesourcery.com>
Date:	Sun, 27 Jul 2008 14:36:52 -0700
From:	Mark Mitchell <mark@codesourcery.com>
Organization: CodeSourcery, Inc.
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	binutils@sourceware.org, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
Subject: Re: RFC: Adding non-PIC executable support to MIPS
References: <87y74pxwyl.fsf@firetop.home> 	<20080724161619.GA18842@caradoc.them.org> <87y73nelq8.fsf@firetop.home>
In-Reply-To: <87y73nelq8.fsf@firetop.home>
X-Enigmail-Version: 0.95.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mark@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark@codesourcery.com
Precedence: bulk
X-list: linux-mips

Richard Sandiford wrote:
> Daniel Jacobowitz <dan@debian.org> writes:
>> All comments welcome - Richard, especially from you.  How would you
>> like to proceed?  I think the first step should be to get your other
>> binutils/gcc patches merged, including MIPS16 PIC; I used those as a
>> base.  But see a few of the notes for potential problems with those
>> patches.
> 
> Yeah, Nick's approved most of the remaining binutils changes (thanks).
> I haven't applied them yet because of the doubt over whether st_size
> should be even or odd for ISA-encoded MIPS16 symbols.  I don't really
> have an opinion, so I'll accept a maintainerly decision...

[I'm not sure if this is a helpful suggestion or not, so feel free to 
ignore it if it's not.]

I would suggest that st_size be the actual size of the function, as it 
lives in memory.  A test of it's start/end location is "could I stick a 
random data byte there and have it affect the function".  For example, 
for a Thumb function whose ISA address is "0x00000001", I would consider 
for size purposes that it starts at "0x00000000", since altering that 
byte at run-time would change the meaning of the function.

-- 
Mark Mitchell
CodeSourcery
mark@codesourcery.com
(650) 331-3385 x713

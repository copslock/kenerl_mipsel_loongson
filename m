Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jun 2004 20:33:07 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:52424 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225716AbUFWTdC>;
	Wed, 23 Jun 2004 20:33:02 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 23 Jun 2004 12:32:26 -0700
Message-ID: <40D9DA3E.3040107@avtrex.com>
Date: Wed, 23 Jun 2004 12:30:06 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: cgd@broadcom.com, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
References: <40C9F5A4.2050606@avtrex.com> <40C9F5FE.8030607@avtrex.com> <40C9F7F0.50501@avtrex.com> <Pine.LNX.4.55.0406112039040.13062@jurand.ds.pg.gda.pl> <mailpost.1086981251.16853@news-sj1-1> <yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com> <Pine.LNX.4.55.0406222304340.23178@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0406222304340.23178@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jun 2004 19:32:26.0681 (UTC) FILETIME=[D0B62A90:01C45958]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>On Fri, 11 Jun 2004 cgd@broadcom.com wrote:
>
>  
>
>>in retrospect, the 'B' variation probably wasn't the greatest idea.
>>
>>If it were removed (leaving 'c' and 'c','q' variations), I don't know
>>that any real harm would occur.
>>
>>It may be very confusing to people who expect that the break code will
>>translate into the instruction in an obvious way, and obviously it
>>would mess up use of 20-bit codes, but i don't know how prevalent that
>>is.
>>
>>Unfortunately, at this point, Linux should probably accept the
>>divide-by-zero code in both locations.
>>
>>
>>(Really, from day one, assemblers probably should have accepted a
>>20-bit code.  I just checked my copy of the Kane r2000/r3000 book, and
>>it was 20-bit all the way back then.  If i had to guess, i'd guess
>>that gas was copying a non-gnu assembler's behaviour.  In any case,
>>water under the bridge.)
>>    
>>
>
> As it's at least annoying to have different break codes for divisions 
>expanded by gcc explicitly and ones created implicitly by gas, here's the 
>most reasonable (IMO) approach to fix that.  I think it should have been 
>implemented this way originally (if at all).
>
>gas/testsuite/:
>2004-06-22  Maciej W. Rozycki  <macro@ds2.pg.gda.pl>
>
>	* gas/mips/break20.s: Test the "break20" alias.
>	* gas/mips/break20.d: Results for the test.
>	* gas/mips/mips32.s: Replace "break" with "break20".
>	* gas/mips/set-arch.s: Likewise.
>	* gas/mips/mips32.d: Adjust for the new output.
>	* gas/mips/set-arch.d: Likewise.
>
>opcodes/:
>2004-06-22  Maciej W. Rozycki  <macro@ds2.pg.gda.pl>
>
>	* mips-opc.c (mips_builtin_opcodes): Replace the MIPS32 ISA 
>	specific "break" encoding with a "break20" alias accepted for any 
>	ISA.
>
>  
>
.
.
.
Just out of curiosity, do you propose this patch in lieu of the patch to 
Linux's traps.c?

Or would you do both?

It seems like both would be best, as there are already "broken" binutils 
floating around out there.

Also nobody has objected to the kernel patch...

David Daney.

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2004 16:36:07 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:13896 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225929AbUFKPgC>;
	Fri, 11 Jun 2004 16:36:02 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 11 Jun 2004 08:33:51 -0700
Message-ID: <40C9D101.3070001@avtrex.com>
Date: Fri, 11 Jun 2004 08:34:25 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: gcc@gcc.gnu.org, linux-mips@linux-mips.org, java@gcc.gnu.org
Subject: Re: [RFC] MIPS division by zero and libgcj...
References: <40C8B29B.3090501@avtrex.com> <Pine.LNX.4.55.0406111554420.13062@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0406111554420.13062@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2004 15:33:51.0302 (UTC) FILETIME=[7F1FAE60:01C44FC9]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>On Thu, 10 Jun 2004, David Daney wrote:
>
>  
>
>>It appears that gcc configured for mipsel-linux will execute a "break 7" 
>>instruction on integer division by zero.
>>
>>This causes the kernel (I am using 2.4.25) to send SIGTRAP.
>>    
>>
>
> It looks like you have a problem in your configuration.  A "break 7"  
>(or "teq <divisor>,$zero,7" -- but that's currently implemented in gas
>only) is indeed emitted and exectuted in the case of division by zero, but
>Linux has the ability to recognize this special break code and sends
>SIGFPE instead.  There are actually two special codes defined, the other
>being "6" for an overflow.  Both are handled by Linux, with si_code in
>struct siginfo being set to FPE_INTDIV or FPE_INTOVF, respectively.  You
>can handle this appropriately in a signal handler.
>
My kernel sources are from linux-mips.org, it is little-endian running on:

# cat /proc/cpuinfo
system type             : ATI-Xilleon
processor               : 0
cpu model               : MIPS 4Kc V0.7
BogoMIPS                : 299.00
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 16
extra interrupt vector  : yes
hardware watchpoint     : yes
VCED exceptions         : not available
VCEI exceptions         : not available

Could you point me to where in the kernel source this is handled?  I 
will try to see what when wrong.

David Daney.

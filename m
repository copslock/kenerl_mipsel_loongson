Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2004 17:34:55 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:55795 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225413AbUANRez>;
	Wed, 14 Jan 2004 17:34:55 +0000
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA05303;
	Wed, 14 Jan 2004 09:34:43 -0800
Message-ID: <40057DB2.7030505@mvista.com>
Date: Wed, 14 Jan 2004 09:34:42 -0800
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Dan Aizenstros <dan@quicklogic.com>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
References: <20040113080926Z8225270-16706+2387@linux-mips.org> <4004295F.9060104@quicklogic.com> <Pine.LNX.4.55.0401141623210.9549@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0401141623210.9549@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>On Tue, 13 Jan 2004, Dan Aizenstros wrote:
>
>  
>
>>You broke any build that does not define CONFIG_SERIAL_AU1X00
>>by adding an #error in the include/asm-mips/serial.h file.
>>
>>-- Dan A.
>>
>>ppopov@linux-mips.org wrote:
>>
>>    
>>
>>>CVSROOT:	/home/cvs
>>>Module name:	linux
>>>Changes by:	ppopov@ftp.linux-mips.org	04/01/13 08:09:22
>>>      
>>>
>
> Thanks for the report.  It looks like a typo.  I've removed the #error
>statement -- Pete please check if that's what's intended.
>  
>
Sorry, typo. Thanks for removing it.

Pete

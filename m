Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Mar 2003 21:44:04 +0000 (GMT)
Received: from amdext2.amd.com ([IPv6:::ffff:163.181.251.1]:13292 "EHLO
	amdext2.amd.com") by linux-mips.org with ESMTP id <S8225193AbTCKVoD>;
	Tue, 11 Mar 2003 21:44:03 +0000
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext2.amd.com (8.9.3/8.9.3/AMD) with ESMTP id PAA19552;
	Tue, 11 Mar 2003 15:43:50 -0600 (CST)
Received: from 163.181.250.1SAUSGW01.amd.com with ESMTP (AMD SMTP Relay
 (MMS v5.0)); Tue, 11 Mar 2003 15:43:43 -0600
X-Server-Uuid: 262C4BA7-64EE-471D-8B02-117625D613AB
Received: from pcsmail.amd.com (pcsmail.amd.com [163.181.41.222]) by
 amdint2.amd.com (8.9.3/8.9.3/AMD) with ESMTP id PAA18627; Tue, 11 Mar
 2003 15:43:40 -0600 (CST)
Received: from amd.com (PC-DEVOLDER.amd.com [163.181.60.19]) by
 pcsmail.amd.com (8.11.6/8.11.6) with ESMTP id h2BLhca07906; Tue, 11 Mar
 2003 15:43:38 -0600
Message-ID: <3E6E588A.1090702@amd.com>
Date: Tue, 11 Mar 2003 15:43:38 -0600
From: "Eric DeVolder" <eric.devolder@amd.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1)
 Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pete Popov" <ppopov@mvista.com>
cc: "Bruno Randolf" <br1@4g-systems.de>, linux-mips@linux-mips.org
Subject: Re: Mycable XXS board
References: <3E689267.3070509@prosyst.bg>
 <20030307133919.P26071@mvista.com> <3E691514.7000907@embeddededge.com>
 <200303111130.57387.br1@4g-systems.de>
 <1047395856.5198.127.camel@zeus.mvista.com>
X-WSS-ID: 127087053189381-01-01
Content-Type: multipart/alternative;
 boundary=------------030008000503030902060102
Return-Path: <eric.devolder@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.devolder@amd.com
Precedence: bulk
X-list: linux-mips


--------------030008000503030902060102
Content-Type: text/plain;
 charset=us-ascii;
 format=flowed
Content-Transfer-Encoding: 7bit

Check linux/arch/mips/au1000/common/irq.c, in function init_IRQ().
Currently all the interrupt assignment are conditionalized per-board,
rather than per-cpu where appropriate. Unless you've changed this
file, I suspect many IRQ setups may be wrong.

Eric

Pete Popov wrote:

>On Tue, 2003-03-11 at 02:30, Bruno Randolf wrote:
>  
>
>>On Friday 07 March 2003 22:54, Dan Malek wrote:
>>
>>    
>>
>>>That's what I wanted to clarify.  Are we discussing one of the on-chip
>>>peripheral USB controllers of the Au1xxx, or is it a PCI USB controller
>>>that was plugged into the Au1500.  In the case of the on-chip controller,
>>>there aren't any interrupt routing problems, it's identical (and the same
>>>code) on all Au1xxx boards.
>>>      
>>>
>>we are discussing the on-chip USB controller for the mycable board. and its 
>>little endian...
>>
>>any ideas where the assignment errors could come from in this case?
>>    
>>
>
>There wouldn't be any. So the problem is not irq assignment related.
>
>I'm not what to suggest here but it feels like it might be a hardware
>issue.  Try adding some printks (the abatron bdi jtag debugger works
>great if you have one) and narrow down what's going on. Do you have any
>jumpers on the board that are not setup correctly?
>
>
>Pete
>
>
>
>  
>


--------------030008000503030902060102
Content-Type: text/html;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
Check linux/arch/mips/au1000/common/irq.c, in function init_IRQ().<br>
Currently all the interrupt assignment are conditionalized per-board,<br>
rather than per-cpu where appropriate. Unless you've changed this<br>
file, I suspect many IRQ setups may be wrong.<br>
<br>
Eric<br>
<br>
Pete Popov wrote:<br>
<blockquote type="cite"
 cite="mid1047395856.5198.127.camel@zeus.mvista.com">
  <pre wrap="">On Tue, 2003-03-11 at 02:30, Bruno Randolf wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Friday 07 March 2003 22:54, Dan Malek wrote:

    </pre>
    <blockquote type="cite">
      <pre wrap="">That's what I wanted to clarify.  Are we discussing one of the on-chip
peripheral USB controllers of the Au1xxx, or is it a PCI USB controller
that was plugged into the Au1500.  In the case of the on-chip controller,
there aren't any interrupt routing problems, it's identical (and the same
code) on all Au1xxx boards.
      </pre>
    </blockquote>
    <pre wrap="">we are discussing the on-chip USB controller for the mycable board. and its 
little endian...

any ideas where the assignment errors could come from in this case?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
There wouldn't be any. So the problem is not irq assignment related.

I'm not what to suggest here but it feels like it might be a hardware
issue.  Try adding some printks (the abatron bdi jtag debugger works
great if you have one) and narrow down what's going on. Do you have any
jumpers on the board that are not setup correctly?


Pete



  </pre>
</blockquote>
<br>
</body>
</html>

--------------030008000503030902060102--

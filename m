Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2004 16:35:32 +0000 (GMT)
Received: from sj-iport-3-in.cisco.com ([IPv6:::ffff:171.71.176.72]:13833 "EHLO
	sj-iport-3.cisco.com") by linux-mips.org with ESMTP
	id <S8225548AbUCYQfb>; Thu, 25 Mar 2004 16:35:31 +0000
Received: from sj-core-2.cisco.com (171.71.177.254)
  by sj-iport-3.cisco.com with ESMTP; 25 Mar 2004 08:41:49 +0000
Received: from mira-sjc5-f.cisco.com (IDENT:mirapoint@mira-sjc5-f.cisco.com [171.71.163.13])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id i2PGZKKj014301;
	Thu, 25 Mar 2004 08:35:21 -0800 (PST)
Received: from cisco.com (ribrober-lnx.cisco.com [128.107.165.17])
	by mira-sjc5-f.cisco.com (Mirapoint Messaging Server MOS 3.3.6-GR)
	with ESMTP id AQM26338;
	Thu, 25 Mar 2004 08:33:49 -0800 (PST)
Message-ID: <40630A46.2000908@cisco.com>
Date: Thu, 25 Mar 2004 08:35:18 -0800
From: Richard Broberg <ribrober@cisco.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: erras stefan <stefan.erras@dallmeier-electronic.com>
CC: linux-mips@linux-mips.org
Subject: Re: PMON - IdentifyFlashType
References: <765921A8173EC145948ACBAA0480F67E2C76D6@server10.dallmeier.de>
In-Reply-To: <765921A8173EC145948ACBAA0480F67E2C76D6@server10.dallmeier.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ribrober@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ribrober@cisco.com
Precedence: bulk
X-list: linux-mips


>Can anybody of you great guys can explain me the folling function which
>I found in PMON:
>
>BOOL IdentifyFlashType()
>{
>	ULONG	mId, dId;
>
>	WRITE_REGISTER_ULONG(FLASH_START, 0x90909090);
>	mId = READ_REGISTER_ULONG(FLASH_START);
>	WRITE_REGISTER_ULONG(FLASH_START, 0x90909090);
>	dId = READ_REGISTER_ULONG(FLASH_START+4);
>	
>	if ((mId == 0x00890089) && (dId == 0x00180018)) 
>	{
>		FlashType = 1;		// J3 flash
>		WRITE_REGISTER_ULONG(FLASH_START, 0x00ff00ff);
>		printf("J3 32MB flash found on this platform\r\n");
>		return TRUE;
>	}	
>	else if ((mId == 0x00890089) && (dId == 0x00170017)) 
>	{	 
>		FlashType = 1;		// J3 flash
>		WRITE_REGISTER_ULONG(FLASH_START, 0x00ff00ff);
>		printf("J3 16MB flash found on this platform\r\n");
>		return TRUE;
>	}
>	return FALSE;
>}
>
>I have to know what the WRITE_REGISTER_ULONG and READ_REGISTER_ULONG
>functions do affect.
>Why do they write 0x90909090 or 0x00ff00ff to FLASH_START?
>  
>
The 90909090 is a command to the flash chip to describe itself.
(I believe the 2nd write of 90909090 is superfluous). Assumptions are
being made about the flash organization and that's why
you see constants 00890089. I believe 00900090 would have
identical effects to 90909090.

The 00FF00FF is a command to the flash chip to revert to
normal operation where reads return flash contents.

>Whats the meaning of mId and dId?
>  
>
manufacturer id and device id.
89 being intel

Good luck
 Richard

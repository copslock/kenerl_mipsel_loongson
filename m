Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2004 15:25:09 +0000 (GMT)
Received: from web.123-box.de ([IPv6:::ffff:193.254.185.98]:29636 "HELO
	web.123-box.de") by linux-mips.org with SMTP id <S8225263AbUCYPZI> convert rfc822-to-8bit;
	Thu, 25 Mar 2004 15:25:08 +0000
Received: (qmail 18702 invoked by uid 110); 25 Mar 2004 15:28:12 -0000
Received: from unknown (HELO server10.dallmeier.de) (217.235.82.140)
  by web.123-box.de with SMTP; 25 Mar 2004 15:28:12 -0000
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: PMON - IdentifyFlashType
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Thu, 25 Mar 2004 16:25:03 +0100
Message-ID: <765921A8173EC145948ACBAA0480F67E2C76D6@server10.dallmeier.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PMON - IdentifyFlashType
thread-index: AcQSfVrEYFBTTkDATxSChIuitybqZw==
From: "erras stefan" <stefan.erras@dallmeier-electronic.com>
To: <linux-mips@linux-mips.org>
Return-Path: <stefan.erras@dallmeier-electronic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefan.erras@dallmeier-electronic.com
Precedence: bulk
X-list: linux-mips

Can anybody of you great guys can explain me the folling function which
I found in PMON:

BOOL IdentifyFlashType()
{
	ULONG	mId, dId;

	WRITE_REGISTER_ULONG(FLASH_START, 0x90909090);
	mId = READ_REGISTER_ULONG(FLASH_START);
	WRITE_REGISTER_ULONG(FLASH_START, 0x90909090);
	dId = READ_REGISTER_ULONG(FLASH_START+4);
	
	if ((mId == 0x00890089) && (dId == 0x00180018)) 
	{
		FlashType = 1;		// J3 flash
		WRITE_REGISTER_ULONG(FLASH_START, 0x00ff00ff);
		printf("J3 32MB flash found on this platform\r\n");
		return TRUE;
	}	
	else if ((mId == 0x00890089) && (dId == 0x00170017)) 
	{	 
		FlashType = 1;		// J3 flash
		WRITE_REGISTER_ULONG(FLASH_START, 0x00ff00ff);
		printf("J3 16MB flash found on this platform\r\n");
		return TRUE;
	}
	return FALSE;
}

I have to know what the WRITE_REGISTER_ULONG and READ_REGISTER_ULONG
functions do affect.
Why do they write 0x90909090 or 0x00ff00ff to FLASH_START?
Whats the meaning of mId and dId?

Thank you all in advance for your help!!!

Greetings
Stefan

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2011 01:37:54 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:3218 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491056Ab1EPXhs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2011 01:37:48 +0200
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Mon, 16 May 2011 16:41:24 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: from IRVEXCHCCR01.corp.ad.broadcom.com ([10.252.49.30]) by
 IRVEXCHHUB01.corp.ad.broadcom.com ([10.9.200.131]) with mapi; Mon, 16
 May 2011 16:37:27 -0700
From:   "Jian Peng" <jipeng@broadcom.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
cc:     "Ralf Baechle" <ralf@linux-mips.org>
Date:   Mon, 16 May 2011 16:37:22 -0700
Subject: RE: patch to support topdown mmap allocation in MIPS
Thread-Topic: patch to support topdown mmap allocation in MIPS
Thread-Index: AcwUDZV1rkskQxMpROqms+cuQJj71wAFAjmg
Message-ID: <E18F441196CA634DB8E1F1C56A50A8743242B54D32@IRVEXCHCCR01.corp.ad.broadcom.com>
References: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com>
In-Reply-To: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: BMWF EYxD EmT6 ExBJ F8gF GEdz JSyk K7VS Mi5G Oy/A
 P8nq U7Mt VlNH WF2n WIQ1
 Wp3W;2;bABpAG4AdQB4AC0AbQBpAHAAcwBAAGwAaQBuAHUAeAAtAG0AaQBwAHMALgBvAHIAZwA7AHIAYQBsAGYAQABsAGkAbgB1AHgALQBtAGkAcABzAC4AbwByAGcA;Sosha1_v1;7;{EB42C5B0-8847-4B37-8AE1-43AD75694A72};agBpAHAAZQBuAGcAQABiAHIAbwBhAGQAYwBvAG0ALgBjAG8AbQA=;Mon,
 16 May 2011 23:37:22
 GMT;UgBFADoAIABwAGEAdABjAGgAIAB0AG8AIABzAHUAcABwAG8AcgB0ACAAdABvAHAAZABvAHcAbgAgAG0AbQBhAHAAIABhAGwAbABvAGMAYQB0AGkAbwBuACAAaQBuACAATQBJAFAAUwA=
x-cr-puzzleid: {EB42C5B0-8847-4B37-8AE1-43AD75694A72}
acceptlanguage: en-US
MIME-Version: 1.0
X-WSS-ID: 61CF69AE1IC8295162-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <jipeng@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jipeng@broadcom.com
Precedence: bulk
X-list: linux-mips

Here is my testing program that intentionally caused OOM by calling mmap() to allocate 8MB each time.

Without patch, it failed at 168th mmap call, and with patch, it failed at 254th mmap call. It is 688MB more usable virtual address space.

/*
 * A simple testing program to cause OOM by calling mmap()
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

void *test_mmap(unsigned long addr, unsigned long size)
{
	void *pMem;

    	pMem = (char *)mmap((void *)addr, size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	printf("%s:addr=0x%08x, size=0x%x, return 0x%08x\n", __FUNCTION__, addr, size, pMem);
	
    	if (MAP_FAILED == pMem)
    	{
		printf("test_mmap FAILED\n");
        	pMem = NULL;
	}

    	return pMem;
}

int main(int argc, char **argv)
{
	int done = 0;
	int keep = 1;

	while(keep)
	{
		int i;
		int loops = 2000000000;

		if(!done) {
			for(i=0; i<loops; i++)
				if(test_mmap(0, 0x800000) == NULL)
				{	
					printf("\t\tFAILED at %d try\n", i);
					break;
				}
			done = 1;
		}	

		sleep(1);
	}
}

-----Original Message-----
From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Jian Peng
Sent: Monday, May 16, 2011 2:10 PM
To: linux-mips@linux-mips.org
Cc: Ralf Baechle
Subject: patch to support topdown mmap allocation in MIPS

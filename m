Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2005 09:41:01 +0000 (GMT)
Received: from amsfep13-int.chello.nl ([IPv6:::ffff:213.46.243.23]:15416 "EHLO
	amsfep13-int.chello.nl") by linux-mips.org with ESMTP
	id <S8224986AbVAYJko>; Tue, 25 Jan 2005 09:40:44 +0000
Received: from [127.0.0.1] (really [62.195.248.222])
          by amsfep13-int.chello.nl
          (InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
          id <20050125094037.MVOY11192.amsfep13-int.chello.nl@[127.0.0.1]>
          for <linux-mips@linux-mips.org>; Tue, 25 Jan 2005 10:40:37 +0100
Message-ID: <41F6141C.7010908@amsat.org>
Date:	Tue, 25 Jan 2005 10:40:44 +0100
From:	Jeroen Vreeken <pe1rxq@amsat.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: RFC: Copyright notice
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <pe1rxq@amsat.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pe1rxq@amsat.org
Precedence: bulk
X-list: linux-mips

Hi,

I have been porting the 2.4.18 based edimax sources for the adm5120 to 
2.6 over the last few days (its alive, atleast untill it blows up in the 
delay measurement :).
I would like some advice on the copyright notices the ADMtek guys put in 
these files....

Below I included one such blurp.
To me it reads like a load of crap.
- It is not unpublished as it states, as they distributed both compiled 
kernels and the sources.
- Tradesecrets are kind of a nonsense if you put your sources on a 
publicly accessable webserver.
- They linked and distributed the result against GPL (kernel, not just 
compiled as a module) code so I am pretty sure we can asume that we 
comply with option II (in other words: we have a license)

Keeping this is going to get people freaked out for sure, would it be ok 
to just change it to 'Copyright ADMtek' and add a few lines refering to 
the GPL?

Thanks,
Jeroen


header of arch/mips/am5120/irq.c:

/*****************************************************************************
;
;   (C) Unpublished Work of ADMtek Incorporated.  All Rights Reserved.
;
;       THIS WORK IS AN UNPUBLISHED WORK AND CONTAINS CONFIDENTIAL,
;       PROPRIETARY AND TRADESECRET INFORMATION OF ADMTEK INCORPORATED.
;       ACCESS TO THIS WORK IS RESTRICTED TO (I) ADMTEK EMPLOYEES WHO HAVE A
;       NEED TO KNOW TO PERFORM TASKS WITHIN THE SCOPE OF THEIR ASSIGNMENTS
;       AND (II) ENTITIES OTHER THAN ADMTEK WHO HAVE ENTERED INTO 
APPROPRIATE
;       LICENSE AGREEMENTS.  NO PART OF THIS WORK MAY BE USED, PRACTICED,
;       PERFORMED, COPIED, DISTRIBUTED, REVISED, MODIFIED, TRANSLATED,
;       ABBRIDGED, CONDENSED, EXPANDED, COLLECTED, COMPILED, LINKED, RECAST,
;       TRANSFORMED OR ADAPTED WITHOUT THE PRIOR WRITTEN CONSENT OF ADMTEK.
;       ANY USE OR EXPLOITATION OF THIS WORK WITHOUT AUTHORIZATION COULD
;       SUBJECT THE PERPERTRATOR TO CRIMINAL AND CIVIL LIABILITY.
;
;------------------------------------------------------------------------------
;
;    Project : ADM5120
;    Creator : daniell@admtek.com.tw
;    File    : arch/mips/am5120/irq.c
;     Date    : 2003.3.4
;    Abstract:
;
;Modification History:
;

;*****************************************************************************/

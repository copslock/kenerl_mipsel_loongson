Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2016 22:48:32 +0100 (CET)
Received: from aserp1040.oracle.com ([141.146.126.69]:47426 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991976AbcLHVs0KnWTa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Dec 2016 22:48:26 +0100
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id uB8LmIMb000453
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 8 Dec 2016 21:48:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.13.8/8.14.4) with ESMTP id uB8LmGCF000368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 8 Dec 2016 21:48:18 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id uB8LmEG1022325;
        Thu, 8 Dec 2016 21:48:16 GMT
Received: from elgon.mountain (/41.202.241.17)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Dec 2016 13:48:14 -0800
Date:   Fri, 9 Dec 2016 00:39:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [bug report] [MIPS] IP22: Fix serial console detection
Message-ID: <20161208213955.GA25569@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.carpenter@oracle.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

[ ancient code... ]

Hello Ralf Baechle,

This is a semi-automatic email about new static checker warnings.

The patch e9feeb207e55: "[MIPS] IP22: Fix serial console detection" 
from Jan 30, 2006, leads to the following Smatch complaint:

arch/mips/sgi-ip22/ip22-setup.c:71 plat_mem_setup()
	 error: we previously assumed 'ctype' could be null (see line 66)

arch/mips/sgi-ip22/ip22-setup.c
    56          /* ARCS console environment variable is set to "g?" for
    57           * graphics console, it is set to "d" for the first serial
    58           * line and "d2" for the second serial line.
    59           *
    60           * Need to check if the case is 'g' but no keyboard:
    61           * (ConsoleIn/Out = serial)
    62           */
    63          ctype = ArcGetEnvironmentVariable("console");
    64          cserial = ArcGetEnvironmentVariable("ConsoleOut");
    65	
    66		if ((ctype && *ctype == 'd') || (cserial && *cserial == 's')) {
                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
Assumed ctype is NULL and *cserial == 's'.

    67			static char options[8] __initdata;
    68			char *baud = ArcGetEnvironmentVariable("dbaud");
    69			if (baud)
    70				strcpy(options, baud);
    71			add_preferred_console("ttyS", *(ctype + 1) == '2' ? 1 : 0,
                                                      ^^^^^^^^^^^^
Then we dereference it here.

    72					      baud ? options : NULL);
    73		} else if (!ctype || *ctype != 'g') {

regards,
dan carpenter

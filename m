Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 May 2013 08:24:49 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:23403 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817318Ab3EXGYmoKaNC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 May 2013 08:24:42 +0200
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     David Daney <ddaney.cavm@gmail.com>,
        "Maciej W. Rozycki" <macro@codesourcery.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] MIPS: Trap exception handling fixes
Thread-Topic: [PATCH] MIPS: Trap exception handling fixes
Thread-Index: AQHOV9cQMMPIOxY+M0GWrH1JOvQ9Z5kT3jfQ
Date:   Fri, 24 May 2013 06:23:17 +0000
Message-ID: <0573B2AE5BBFFC408CC8740092293B5ACD29B5@bamail02.ba.imgtec.org>
References: <alpine.DEB.1.10.1305230253140.26443@tp.orcam.me.uk>
 <20130523155009.GA5598@linux-mips.org>
 <alpine.DEB.1.10.1305231656020.26443@tp.orcam.me.uk>
 <alpine.DEB.1.10.1305231744460.26443@tp.orcam.me.uk>,<519E4B35.10507@gmail.com>
In-Reply-To: <519E4B35.10507@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.64.117]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01181__2013_05_24_07_24_33
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

I am working on a patch to fix the microMIPS BREAK encoding. This was already discovered when we were regression testing for our 'linux-mti-3.8' branch release. With regards to the MIPS16e path, I will need to take a closer look.

Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Mar 2013 11:02:14 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:65028 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816154Ab3CPUyBHRU7P convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Mar 2013 21:54:01 +0100
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     Florian Fainelli <florian@openwrt.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     "blogic@openwrt.org" <blogic@openwrt.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] MIPS: fix code generation for non-DSP capable CPUs
Thread-Topic: [PATCH] MIPS: fix code generation for non-DSP capable CPUs
Thread-Index: AQHOILcC+TzF+sBpekS+sLm1UdB6zJiozhcB
Date:   Sat, 16 Mar 2013 20:52:44 +0000
Message-ID: <0573B2AE5BBFFC408CC8740092293B5ACBB9B0@bamail02.ba.imgtec.org>
References: <1363267128-8918-1-git-send-email-florian@openwrt.org>
In-Reply-To: <1363267128-8918-1-git-send-email-florian@openwrt.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.64.117]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01181__2013_03_16_20_53_54
X-archive-position: 35898
X-Approved-By: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Florian,

I just tested this patch with our DSP testsuite and everything works. I also disassembled the vmlinux ELF binary to make sure the instructions were being generated correctly.


Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>

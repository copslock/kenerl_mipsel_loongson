Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:10:37 +0100 (CET)
Received: from smtp2.infineon.com ([217.10.60.23]:14027 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903646Ab2CNJKc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Mar 2012 10:10:32 +0100
X-SBRS: None
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ADH-AES256-SHA; 14 Mar 2012 10:10:37 +0100
Received: from MUCSE595.eu.infineon.com (mucse595.eu.infineon.com [172.23.7.84])
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-mips@linux-mips.org>; Wed, 14 Mar 2012 10:10:25 +0100 (CET)
Received: from MUCSE501.eu.infineon.com ([169.254.7.124]) by
 MUCSE595.eu.infineon.com ([172.23.7.84]) with mapi id 14.01.0355.002; Wed, 14
 Mar 2012 10:10:21 +0100
From:   <Narendra.Puttaswamy@lantiq.com>
To:     <linux-mips@linux-mips.org>
Subject: Sys exception behavior
Thread-Topic: Sys exception behavior
Thread-Index: Ac0Bwkc/JegQZ0JMTaOUxImXNJieyg==
Date:   Wed, 14 Mar 2012 09:10:20 +0000
Message-ID: <93D430A75FD60048911C7ED0A8F56E830AF688@MUCSE501.eu.infineon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.8.248]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 32668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Narendra.Puttaswamy@lantiq.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


Soon after "syscall" instruction is executed in the user mode, does the processor ensure that it raises an exception with the appropriate exception code (sys)  set in Cause register *irrespective* of other high priority exception (for example, an interrupt) that may have occurred at that time.

Looking into the source code of scall32-o32.S file, I infer the above. Can somebody please confirm the behavior?

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 12:46:50 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:59889 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028899AbcELKqsoRLKP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2016 12:46:48 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FD6EC057EC9
        for <linux-mips@linux-mips.org>; Thu, 12 May 2016 10:46:40 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4CAkcC9006372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <linux-mips@linux-mips.org>; Thu, 12 May 2016 06:46:39 -0400
To:     linux-mips@linux-mips.org
From:   Florian Weimer <fweimer@redhat.com>
Subject: Endless loop on execution attempt on non-executable page
Message-ID: <57345F0D.9070503@redhat.com>
Date:   Thu, 12 May 2016 12:46:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 12 May 2016 10:46:40 +0000 (UTC)
Return-Path: <fweimer@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweimer@redhat.com
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

The GCC compile farm has a big-endian 64-bit MIPS box.  The kernel is:

Linux erpro8-fsf1 3.14.10-er8mod-00013-ge0fe977 #1 SMP PREEMPT Wed Jan
14 12:33:22 PST 2015 mips64 GNU/Linux

Which is a vendor kernel for the EdgeRouter Pro-8.

/proc/cpuinfo reports:

system type             : UBNT_E200 (CN6120p1.1-1000-NSP)
machine                 : Unknown
processor               : 0
cpu model               : Cavium Octeon II V0.1

While testing W^X (execmod, DEP, NX) stack enforcement, I noticed that 
once I try to execute code off a non-executable page, I do not get a 
signal, but the code appears to enter an infinite loop.  The generated 
function starts with a jump instruction to return to the caller, but 
instead, the program counter does not seem to change at all.

“si” in GDB also hangs (but can be interrupted with ^C).

My test code is here:

   https://pagure.io/execmod-tests

Is this a kernel bug or an issue with the silicon?

Thanks,
Florian

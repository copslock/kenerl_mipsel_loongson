Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 11:49:51 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:46884 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993264AbcHRJrdA7jVP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 11:47:33 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5943B919;
        Thu, 18 Aug 2016 09:47:26 +0000 (UTC)
Subject: Patch "[PATCH BACKPORT 3.17-4.4 4/4] MIPS: KVM: Propagate kseg0/mapped tlb fault errors" has been added to the 4.4-stable tree
To:     james.hogan@imgtec.com, gregkh@linuxfoundation.org,
        kvm@vger.kernel.org, linux-mips@linux-mips.org,
        pbonzini@redhat.com, ralf@linux-mips.org, rkrcmar@redhat.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 18 Aug 2016 11:47:23 +0200
In-Reply-To: <bc64b178eead8f261016756dc6d1348f4eba638c.1471018436.git-series.james.hogan@imgtec.com>
Message-ID: <1471513643214168@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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


This is a note to let you know that I've just added the patch titled

    [PATCH BACKPORT 3.17-4.4 4/4] MIPS: KVM: Propagate kseg0/mapped tlb fault errors

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-kvm-propagate-kseg0-mapped-tlb-fault-errors.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.

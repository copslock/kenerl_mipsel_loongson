Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 15:34:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32447 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011673AbbKPOeR0YxPR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2015 15:34:17 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 143619521C0C8;
        Mon, 16 Nov 2015 14:34:09 +0000 (GMT)
Received: from [10.100.200.62] (10.100.200.62) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server id 14.3.235.1; Mon, 16 Nov 2015
 14:34:11 +0000
Date:   Mon, 16 Nov 2015 14:34:09 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Daniel Sanders <Daniel.Sanders@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/4] MIPS: IEEE Std 754 NaN interlinking support
Message-ID: <alpine.DEB.2.00.1511161358211.7097@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Hi,

 This implements the kernel part of IEEE Std 754 NaN interlinking support, 
as per "MIPS ABI Extension for IEEE Std 754 Non-Compliant Interlinking" 
<https://dmz-portal.mips.com/wiki/MIPS_ABI_-_NaN_Interlinking>.

 Four patches are included: a pair of preparatory changes, a generic one 
to allow ports to provide their own auxiliary vector's AT_FLAGS entry 
initialiser and one factoring out pieces of FP context maintenance code, 
respectively, and then a pair of actual changes, implementing the NaN 
interlinking feature proper and a prctl(2) interface to switch the 
compliance mode dynamically respectively.

 These patches rely on 2008-NaN support, recently posted, having been 
applied first.

 At this point this is a request for comments only rather than an actual 
patch submission for inclusion, as consensus about the specification has 
to be reached first.  All feedback is welcome on the implementation and 
I'll be happy to address any questions, comments or concerns.

  Maciej

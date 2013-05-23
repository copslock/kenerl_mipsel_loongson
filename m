Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 18:07:49 +0200 (CEST)
Received: from relay1.mentorg.com ([192.94.38.131]:57232 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835061Ab3EWQHoTYp1o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 18:07:44 +0200
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
        by relay1.mentorg.com with esmtp 
        id 1UfY3K-0001qO-CY from Maciej_Rozycki@mentor.com ; Thu, 23 May 2013 09:07:42 -0700
Received: from SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) by svr-orw-fem-01.mgc.mentorg.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 May 2013 09:07:42 -0700
Received: from [172.30.64.76] (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server id 14.2.247.3; Thu, 23 May 2013
 17:07:40 +0100
Date:   Thu, 23 May 2013 17:07:35 +0100
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Trap exception handling fixes
In-Reply-To: <20130523155009.GA5598@linux-mips.org>
Message-ID: <alpine.DEB.1.10.1305231656020.26443@tp.orcam.me.uk>
References: <alpine.DEB.1.10.1305230253140.26443@tp.orcam.me.uk> <20130523155009.GA5598@linux-mips.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-OriginalArrivalTime: 23 May 2013 16:07:42.0147 (UTC) FILETIME=[A7910930:01CE57CF]
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
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

On Thu, 23 May 2013, Ralf Baechle wrote:

> Seems that whole bloody patchset was painfully unripe :-(

 Sigh, I meant to at least skim over the patches to review them, but these 
days I can hardly find time for smaller changes even.  This particular 
issue was found in GCC regression testing.  I think at least running the 
GCC and glibc test suites across the three ABIs and both endiannesses each 
to make sure MIPS16/microMIPS support didn't regress standard MIPS support 
was due.  This would have avoided this problem.  It looks to me do_bp 
would benefit from some polishing too.

  Maciej

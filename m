Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 May 2013 08:45:52 +0200 (CEST)
Received: from relay1.mentorg.com ([192.94.38.131]:65518 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823690Ab3EXGpu7gdJy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 May 2013 08:45:50 +0200
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
        by relay1.mentorg.com with esmtp 
        id 1Ufll1-0000l4-6u from Maciej_Rozycki@mentor.com ; Thu, 23 May 2013 23:45:43 -0700
Received: from SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) by SVR-ORW-EXC-10.mgc.mentorg.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 May 2013 23:45:42 -0700
Received: from [172.30.64.79] (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server id 14.2.247.3; Fri, 24 May 2013
 07:45:41 +0100
Date:   Fri, 24 May 2013 07:45:36 +0100
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] MIPS: Trap exception handling fixes
In-Reply-To: <0573B2AE5BBFFC408CC8740092293B5ACD29B5@bamail02.ba.imgtec.org>
Message-ID: <alpine.DEB.1.10.1305240745020.26443@tp.orcam.me.uk>
References: <alpine.DEB.1.10.1305230253140.26443@tp.orcam.me.uk> <20130523155009.GA5598@linux-mips.org> <alpine.DEB.1.10.1305231656020.26443@tp.orcam.me.uk> <alpine.DEB.1.10.1305231744460.26443@tp.orcam.me.uk>,<519E4B35.10507@gmail.com>
 <0573B2AE5BBFFC408CC8740092293B5ACD29B5@bamail02.ba.imgtec.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-OriginalArrivalTime: 24 May 2013 06:45:42.0862 (UTC) FILETIME=[4FB836E0:01CE584A]
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36583
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

On Fri, 24 May 2013, Steven J. Hill wrote:

> I am working on a patch to fix the microMIPS BREAK encoding. This was 
> already discovered when we were regression testing for our 
> 'linux-mti-3.8' branch release. With regards to the MIPS16e path, I will 
> need to take a closer look.

 Great, thanks!

  Maciej

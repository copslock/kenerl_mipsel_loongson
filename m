Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2014 18:38:34 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42260 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822287AbaBURib2qCMR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Feb 2014 18:38:31 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s1LHcTfY019020;
        Fri, 21 Feb 2014 18:38:29 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s1LHcToI019019;
        Fri, 21 Feb 2014 18:38:29 +0100
Date:   Fri, 21 Feb 2014 18:38:29 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 3/5] MIPS: Set page size to 16KB for malta SMP defconfigs
Message-ID: <20140221173829.GI19285@linux-mips.org>
References: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com>
 <1392904828-12969-4-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392904828-12969-4-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Feb 20, 2014 at 02:00:26PM +0000, Markos Chandras wrote:

> From: Paul Burton <paul.burton@imgtec.com>
> 
> For Malta defconfigs which may run on an SMP configuration without
> hardware cache anti-aliasing, a 16KB page size is a safer default.
> Most notably at the moment it will avoid cache aliasing issues for
> multicore proAptiv systems.

You're aware that this may cause binary compatibility issues with old
userland?  So far the defaults were chosen to maximise compatibility
over performance.

  Ralf

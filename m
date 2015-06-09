Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jun 2015 20:53:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40077 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008354AbbFISx3ED5hH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Jun 2015 20:53:29 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t59IrR2I016878;
        Tue, 9 Jun 2015 20:53:27 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t59IrPWO016877;
        Tue, 9 Jun 2015 20:53:25 +0200
Date:   Tue, 9 Jun 2015 20:53:24 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Upgrade of linux-mips.org
Message-ID: <20150609185324.GD2753@linux-mips.org>
References: <20150601130558.GB27051@linux-mips.org>
 <5577342A.40206@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5577342A.40206@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47908
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

On Tue, Jun 09, 2015 at 01:44:58PM -0500, Steven J. Hill wrote:

> On 06/01/2015 08:05 AM, Ralf Baechle wrote:
> > Over the weekend I've upgraded linux-mips.org's Linux distribution.  I think
> > everything should be running fine again but just in case you notice any
> > issues, please report to me or the mailing list.
> > 
> I cannot connect over port 22 with SSH with interactive shell or with
> git. Is anyone else having connection problems? Thanks.

Lmo has multiple IPs.  Due to the excessive number of ssh probes which on
a bad day may actually go ino the 5 digit figures and consume a good bit
of resources in peak times I've limited ssh service to just one address,
148.251.95.138 / 2a01:4f8:201:92aa::3 which is www.linux-mips.org and a
few several other host names.

  Ralf

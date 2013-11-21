Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2013 18:55:54 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33722 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817128Ab3KURzwZUuSc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Nov 2013 18:55:52 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id rALHtpAP019742;
        Thu, 21 Nov 2013 18:55:51 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id rALHtoW3019741;
        Thu, 21 Nov 2013 18:55:50 +0100
Date:   Thu, 21 Nov 2013 18:55:50 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mark Salter <msalter@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 07/11] mips: use generic fixmap.h
Message-ID: <20131121175550.GU10382@linux-mips.org>
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
 <1384262545-20875-8-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1384262545-20875-8-git-send-email-msalter@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38566
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

On Tue, Nov 12, 2013 at 08:22:21AM -0500, Mark Salter wrote:
> Date:   Tue, 12 Nov 2013 08:22:21 -0500
> From: Mark Salter <msalter@redhat.com>
> To: linux-kernel@vger.kernel.org
> Cc: Mark Salter <msalter@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
>  linux-mips@linux-mips.org
> Subject: [PATCH 07/11] mips: use generic fixmap.h

For patches 1/7 and this patch:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks!

  Ralf

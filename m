Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 09:02:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37675 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823123Ab3JHHCKAoKpj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 09:02:10 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r98729PX009589;
        Tue, 8 Oct 2013 09:02:09 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r98729RI009586;
        Tue, 8 Oct 2013 09:02:09 +0200
Date:   Tue, 8 Oct 2013 09:02:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mark Salter <msalter@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 07/14] mips: select ARCH_MAY_HAVE_PC_PARPORT
Message-ID: <20131008070209.GF1615@linux-mips.org>
References: <1381209030-351-1-git-send-email-msalter@redhat.com>
 <1381209030-351-8-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1381209030-351-8-git-send-email-msalter@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38252
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

On Tue, Oct 08, 2013 at 01:10:23AM -0400, Mark Salter wrote:

> Architectures which support CONFIG_PARPORT_PC should select
> ARCH_MAY_HAVE_PC_PARPORT.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf

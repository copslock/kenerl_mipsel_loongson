Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 14:48:35 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57707 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491047Ab0JNMsc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Oct 2010 14:48:32 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9ECmRG4032606;
        Thu, 14 Oct 2010 13:48:27 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9ECmRxU032604;
        Thu, 14 Oct 2010 13:48:27 +0100
Date:   Thu, 14 Oct 2010 13:48:27 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Al Viro <viro@ftp.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/5] mips: don't block signals if we'd failed setting
 sigframe up
Message-ID: <20101014124827.GA32284@linux-mips.org>
References: <E1P0eJl-0006im-4g@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1P0eJl-0006im-4g@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Thanks, applied.

  Ralf

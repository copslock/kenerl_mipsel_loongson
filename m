Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2012 17:50:39 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:37031 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903683Ab2EYPu3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 May 2012 17:50:29 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q4PFoSaQ015751;
        Fri, 25 May 2012 16:50:28 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q4PFoQCU015748;
        Fri, 25 May 2012 16:50:26 +0100
Date:   Fri, 25 May 2012 16:50:26 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2] Update all configuration files for new features.
Message-ID: <20120525155026.GA14020@linux-mips.org>
References: <1337893403-24696-1-git-send-email-sjhill@mips.com>
 <4FBF6AD9.6060001@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FBF6AD9.6060001@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33467
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, May 25, 2012 at 03:19:53PM +0400, Sergei Shtylyov wrote:

>    I think you should use 'make savedefconfig' to save space on
> non-seleected items. At least 'malta_defconfig' was clearly
> generated that way before -- using that target has become a common
> practice nowadays.

Yep.  And Linus practically declared full size config files a shooting
offence.

  Ralf

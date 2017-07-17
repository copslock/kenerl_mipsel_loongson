Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jul 2017 15:48:06 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59310 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994826AbdGQNr6Gu0h1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jul 2017 15:47:58 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 311AE72A;
        Mon, 17 Jul 2017 13:47:51 +0000 (UTC)
Date:   Mon, 17 Jul 2017 15:47:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Cc:     Aleksa Sarai <asarai@suse.de>,
        David Laight <David.Laight@ACULAB.COM>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Valentin Rothberg <vrothberg@suse.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>, Jiri Slaby <jslaby@suse.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] [PING] Fix TIOCGPTPEER ioctl definition
Message-ID: <20170717134746.GA19574@kroah.com>
References: <20170717132946.GK21910@glebfm.cloud.tilaa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717132946.GK21910@glebfm.cloud.tilaa.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59122
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

On Mon, Jul 17, 2017 at 04:29:46PM +0300, Gleb Fotengauer-Malinovskiy wrote:
> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
> because it doesn't copy anything from/to userspace to access the
> argument.
> 
> Fixes: 54ebbfb16034 ("tty: add TIOCGPTPEER ioctl")
> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> Acked-by: Aleksa Sarai <asarai@suse.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>


Why the PING?  -rc1 just happened, so I am only now able to apply the
patch to the tree.  Please relax, you are behind about 800+ other
patches in my queue...

thanks,

greg k-h

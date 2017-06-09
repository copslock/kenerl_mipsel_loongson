Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jun 2017 11:27:32 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48152 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991957AbdFIJ1NsDjNA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jun 2017 11:27:13 +0200
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DD0B7B7A;
        Fri,  9 Jun 2017 09:27:06 +0000 (UTC)
Date:   Fri, 9 Jun 2017 11:26:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aleksa Sarai <asarai@suse.de>
Cc:     Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Valentin Rothberg <vrothberg@suse.com>
Subject: Re: [PATCH v4 2/2] tty: add TIOCGPTPEER ioctl
Message-ID: <20170609092659.GA26933@kroah.com>
References: <20170603141515.9529-1-asarai@suse.de>
 <20170603141515.9529-3-asarai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170603141515.9529-3-asarai@suse.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58377
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

On Sun, Jun 04, 2017 at 12:15:15AM +1000, Aleksa Sarai wrote:
> When opening the slave end of a PTY, it is not possible for userspace to
> safely ensure that /dev/pts/$num is actually a slave (in cases where the
> mount namespace in which devpts was mounted is controlled by an
> untrusted process). In addition, there are several unresolvable
> race conditions if userspace were to attempt to detect attacks through
> stat(2) and other similar methods [in addition it is not clear how
> userspace could detect attacks involving FUSE].
> 
> Resolve this by providing an interface for userpace to safely open the
> "peer" end of a PTY file descriptor by using the dentry cached by
> devpts. Since it is not possible to have an open master PTY without
> having its slave exposed in /dev/pts this interface is safe. This
> interface currently does not provide a way to get the master pty (since
> it is not clear whether such an interface is safe or even useful).
> 
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Valentin Rothberg <vrothberg@suse.com>
> Signed-off-by: Aleksa Sarai <asarai@suse.de>

Is this going to be documented anywhere?  Is there a man page update
that also goes along with this?  What userspace program wants to use
this?

I'm not objecting to this, I just want to know that people will use
this, and that they can find out information about it if they want to.

thanks,

greg k-h

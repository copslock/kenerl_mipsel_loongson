Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2005 11:14:37 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:274 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133447AbVJCKKT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Oct 2005 11:10:19 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j93AA4Mc001842;
	Mon, 3 Oct 2005 11:10:14 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8UMk81c014583;
	Fri, 30 Sep 2005 23:46:08 +0100
Date:	Fri, 30 Sep 2005 23:46:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Cc:	Jan Pedersen <jan.pedersen@glaze.dk>, linux-mips@linux-mips.org
Subject: Re: support for NS DP83847
Message-ID: <20050930224608.GB14463@linux-mips.org>
References: <20050920211245.730CF376471@rocket.glaze.se> <43307CA9.1070506@total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43307CA9.1070506@total-knowledge.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 20, 2005 at 02:18:33PM -0700, Ilya A. Volynets-Evenbakh wrote:

> If you are interested in any patches being accepted into LMO CVS tree,
> you should email patches in question, not URLs. Noone will bother looking
> up your stuff on the web.

Or simply see Documentation/SubmittingPatches:

[...]
6) No MIME, no links, no compression, no attachments.  Just plain text.

Linus and other kernel developers need to be able to read and comment
on the changes you are submitting.  It is important for a kernel
developer to be able to "quote" your changes, using standard e-mail
tools, so that they may comment on specific portions of your code.

For this reason, all patches should be submitting e-mail "inline".
WARNING:  Be wary of your editor's word-wrap corrupting your patch,
if you choose to cut-n-paste your patch.

Do not attach the patch as a MIME attachment, compressed or not.
Many popular e-mail applications will not always transmit a MIME
attachment as plain text, making it impossible to comment on your
code.  A MIME attachment also takes Linus a bit more time to process,
decreasing the likelihood of your MIME-attached change being accepted.

Exception:  If your mailer is mangling patches then someone may ask
you to re-send them using MIME.
[...]

I'm doing plenty of the MIPS maintenance work offline, so URLs really
don't fly.

  Ralf

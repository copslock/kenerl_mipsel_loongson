Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 14:31:29 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:40141 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008944AbbCYNb2Igi7S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2015 14:31:28 +0100
Received: from localhost (samsung-greg.rsr.lip6.fr [132.227.76.96])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A0CC5AE7;
        Wed, 25 Mar 2015 13:31:21 +0000 (UTC)
Date:   Wed, 25 Mar 2015 13:37:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] MIPS: Add CDMM bus support
Message-ID: <20150325123756.GA2200@kroah.com>
References: <1422877510-29247-1-git-send-email-james.hogan@imgtec.com>
 <1422877510-29247-3-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1422877510-29247-3-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46518
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

On Mon, Feb 02, 2015 at 11:45:09AM +0000, James Hogan wrote:
> +struct bus_type mips_cdmm_bustype = {
> +	.name		= "cdmm",
> +	.dev_attrs	= mips_cdmm_dev_attrs,

.dev_attrs is going away "soon", please use dev_groups instead here.

thanks,

greg k-h

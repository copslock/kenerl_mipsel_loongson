Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2012 14:14:52 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:11343 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823020Ab2LZNOvvhKrX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Dec 2012 14:14:51 +0100
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qBQDElVl001906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 26 Dec 2012 08:14:47 -0500
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id qBQDEkTp031459;
        Wed, 26 Dec 2012 08:14:46 -0500
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id 0528018D414; Wed, 26 Dec 2012 15:14:45 +0200 (IST)
Date:   Wed, 26 Dec 2012 15:14:45 +0200
From:   Gleb Natapov <gleb@redhat.com>
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 02/18] KVM/MIPS32: Arch specific KVM data structures.
Message-ID: <20121226131445.GH17584@redhat.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
 <1353551656-23579-3-git-send-email-sanjayl@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1353551656-23579-3-git-send-email-sanjayl@kymasys.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
X-archive-position: 35323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gleb@redhat.com
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

On Wed, Nov 21, 2012 at 06:34:00PM -0800, Sanjay Lal wrote:
> +
> +#ifndef __unused
> +#define __unused __attribute__((unused))
> +#endif
> +
There are __maybe_unused and __always_unused, no need to define your
own.

--
			Gleb.

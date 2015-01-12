Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 20:05:06 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:57468 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010715AbbALTFEovIok (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2015 20:05:04 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 255E821B816;
        Mon, 12 Jan 2015 21:05:04 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id bLsyzh6N72nn; Mon, 12 Jan 2015 21:04:59 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 1BF1D5BC00C;
        Mon, 12 Jan 2015 21:04:59 +0200 (EET)
Date:   Mon, 12 Jan 2015 21:04:58 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Abhishek Paliwal <abhishek.paliwal@aricent.com>
Cc:     kexin.hao@windriver.com, bo.liu@windriver.com,
        Chandrakala.Chavva@caviumnetworks.com, rakesh.garg@aricent.com,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        linux-mips@linux-mips.org, David Daney <ddaney.cavm@gmail.com>,
        James Hogan <james.hogan@imgtec.com>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/9] MIPS OCTEON Add OCTEON3 to get cpu type
Message-ID: <20150112190458.GA10768@fuloong-minipc.musicnaut.iki.fi>
References: <1421046385-2535-1-git-send-email-abhishek.paliwal@aricent.com>
 <1421046385-2535-2-git-send-email-abhishek.paliwal@aricent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1421046385-2535-2-git-send-email-abhishek.paliwal@aricent.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Mon, Jan 12, 2015 at 12:36:17PM +0530, Abhishek Paliwal wrote:
> commit cd3f5389489146297eb2c11e4f9d1c4e8aaeb59f upstream

If you want to avoid surprises by git automatically cc'ing public mailing
lists and people based on the commit log, please set sendmail.supresscc
to "all". For further information check the git documentation.

A.

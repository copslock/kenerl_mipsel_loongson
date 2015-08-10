Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2015 21:19:36 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51441 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012919AbbHJTTfTKaba (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Aug 2015 21:19:35 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 322C63EE;
        Mon, 10 Aug 2015 19:19:29 +0000 (UTC)
Date:   Mon, 10 Aug 2015 12:19:28 -0700
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [4.1,013/123] MIPS: c-r4k: Fix cache flushing for MT cores
Message-ID: <20150810191928.GA7925@kroah.com>
References: <20150808220718.304261727@linuxfoundation.org>
 <55C8EF32.5010807@imgtec.com>
 <20150810184953.GA19646@kroah.com>
 <55C8F785.5020605@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55C8F785.5020605@imgtec.com>
User-Agent: Mutt/1.5.23+102 (2ca89bed6448) (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48755
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

On Mon, Aug 10, 2015 at 12:12:05PM -0700, Leonid Yegoshin wrote:
> On 08/10/2015 11:49 AM, gregkh@linuxfoundation.org wrote:
> >On Mon, Aug 10, 2015 at 11:36:34AM -0700, Leonid Yegoshin wrote:
> >>
> >So, this is broken in Linus's tree too?
> 
> Yes.

Great, as long as I am consistent, that's all that I care about :)

> >   Or is it fixed there, and if
> >so, what is the git commit id?
> 
> There is no an accepted fix. My old patch is in
> 
> https://git.linux-mips.org/cgit/yegoshin/mips.git/commit/?id=98f6c462eb5319a4dcb3830f902c48141f38cd12
> 
> It was a precursor for my EVA set of patches since2.6.35.9 but was never
> accepted and was lost during redesign of EVA by Markos.

Please work with the mips developers to get this accepted, and mark it
for -stable as well.

thanks,

greg k-h

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2014 12:12:33 +0100 (CET)
Received: from bastet.se.axis.com ([195.60.68.11]:34418 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824787AbaCQLM1z9TxH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Mar 2014 12:12:27 +0100
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id A69DE1807E;
        Mon, 17 Mar 2014 12:12:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id aDadZBnG0qI9; Mon, 17 Mar 2014 12:12:20 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id EE2AF18082;
        Mon, 17 Mar 2014 12:12:19 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id D792CDEB;
        Mon, 17 Mar 2014 12:12:19 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id CC94F916;
        Mon, 17 Mar 2014 12:12:19 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by seth.se.axis.com (Postfix) with ESMTP id CAB483E048;
        Mon, 17 Mar 2014 12:12:19 +0100 (CET)
Received: from xmail2.se.axis.com ([10.0.5.74]) by xmail2.se.axis.com
 ([10.0.5.74]) with mapi; Mon, 17 Mar 2014 12:12:19 +0100
From:   Lars Persson <lars.persson@axis.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:   Mon, 17 Mar 2014 12:12:18 +0100
Subject: RE: [PATCH] MIPS: Fix syscall tracing interface
Thread-Topic: [PATCH] MIPS: Fix syscall tracing interface
Thread-Index: Ac9BxUVZyN7/XkP5StqF9R/bqqz0mwADFYOw
Message-ID: <771471B8871B5044A6CA7CCD9C26EEE10117E2936017@xmail2.se.axis.com>
References: <1395042021-6186-1-git-send-email-larper@axis.com>
 <5326BFE1.2060400@imgtec.com>
In-Reply-To: <5326BFE1.2060400@imgtec.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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

Thanks, I will resubmit a patch based on the mips-for-linux-next branch.

- Las

> -----Original Message-----
> From: Markos Chandras [mailto:Markos.Chandras@imgtec.com]
> Sent: den 17 mars 2014 10:27
> To: Lars Persson; linux-mips@linux-mips.org
> Cc: Lars Persson
> Subject: Re: [PATCH] MIPS: Fix syscall tracing interface
> 
> Hi Lars,
> 
> On 03/17/2014 07:40 AM, Lars Persson wrote:
> > The MIPS syscall tracing interface had multiple bugs that made it
> > completely unusable.
> >
> > Signed-off-by: Lars Persson <larper@axis.com>
> 
> The last part of your patch will conflict with
> 
> http://patchwork.linux-mips.org/patch/6402/
> 
> which is already in the linux-next tree.
> 
> The rest of the changes look reasonable to me.
> 
> I believe it is best if you base your patches on upstream-sfr/mips-for-
> linux-next[1] branch.
> 
> [1]
> http://git.linux-mips.org/?p=ralf/upstream-
> sfr.git;a=shortlog;h=refs/heads/mips-for-linux-next
> 
> --
> markos

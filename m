Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 12:25:26 +0200 (CEST)
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52291 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993197AbcHRKZMALvWK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 12:25:12 +0200
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2A560204B8;
        Thu, 18 Aug 2016 06:25:11 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 18 Aug 2016 06:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=kF4Ej18AzjK5IQQdpNKUEOPWkXU=; b=o95ML
        QvWO44vTkrI3scNV++3/kOAzpO9iAt9zBbuSBfYKaI5rcZDFJVNhNiL7PsRPOXSw
        T3/s7w40NnNWdCZeVvLajFPMuXbdiubDTWtL4s1yFnqp0uVitFD1PNlsFzJwyYpp
        TZqeWjDlpPSKK0vsieCSvI/yQOXAa7pf/JRzSs=
X-Sasl-enc: BUCRL2UEKJFbuguRDyHdp6eoY/kGnDa34bsrxfqk8kZM 1471515910
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9E551F2986;
        Thu, 18 Aug 2016 06:25:10 -0400 (EDT)
Date:   Thu, 18 Aug 2016 12:25:21 +0200
From:   Greg KH <greg@kroah.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH BACKPORT 4.7 0/4] MIPS: KVM: Fix MMU/TLB management issues
Message-ID: <20160818102521.GA21052@kroah.com>
References: <cover.d02ea4d58713b53527649c3ad5487b32fd8df3cd.1471018462.git-series.james.hogan@imgtec.com>
 <20160818094217.GA1509@kroah.com>
 <20160818100036.GE19514@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160818100036.GE19514@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.6.2 (2016-07-01)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
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

On Thu, Aug 18, 2016 at 11:00:36AM +0100, James Hogan wrote:
> On Thu, Aug 18, 2016 at 11:42:17AM +0200, Greg KH wrote:
> > On Thu, Aug 18, 2016 at 10:01:25AM +0100, James Hogan wrote:
> > > These patches backport fixes for several issues in the management of
> > > MIPS KVM TLB faults to v4.7.
> > 
> > Thanks for these, now applied.
> 
> Thanks Greg,
> 
> btw, is it okay to tag for stable in this way, knowing full well that
> they'll all conflict and require backports?
> 
> Depending on your FAILED emails before sending backports just seemed
> easier from my point of view, but if that increases any manual effort on
> the part of the stable maintainers I can do it differently in future.

That's fine with me, but if you know they are going to need to be
backported, you can send those before you get the FAILED message so that
I know to use those instead.

thanks,

greg k-h

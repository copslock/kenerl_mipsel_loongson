Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 19:52:56 +0200 (CEST)
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60143 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817165AbaETRwyew00M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 May 2014 19:52:54 +0200
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A537420EE8;
        Tue, 20 May 2014 13:52:48 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 20 May 2014 13:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=message-id:date:from:mime-version:to:cc
        :subject:references:in-reply-to:content-type
        :content-transfer-encoding; s=smtpout; bh=QJn29F7xZZfyq6psUiDUWj
        Rcg2w=; b=UuusXsXFtwykkl0Kyz2UuftqNXHsSJNFX7/fSddexQrmy/QWV7jPUA
        k9LleUiA1zIABccJ9shuJ60XrMsCROtgjprsBAyrBLtZYh7ywkDRxXASnL/e6whv
        0Rl9FJYBqqqDJNutY+KXJRydJuIS4K0wnNAtHeL01V29X4HOKdoB4=
X-Sasl-enc: QhPkW+81tCSgxeZ3vH8fIcs/MZcOSOrHX2sFr/BMilIx 1400608368
Received: from localhost.localdomain (unknown [83.249.107.137])
        by mail.messagingengine.com (Postfix) with ESMTPA id 60BF0680175;
        Tue, 20 May 2014 13:52:47 -0400 (EDT)
Message-ID: <537B966E.9000708@iki.fi>
Date:   Tue, 20 May 2014 20:52:46 +0300
From:   Pekka Enberg <penberg@iki.fi>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 00/12] kvm tools: Misc patches (mips support)
References: <1400518411-9759-1-git-send-email-andreas.herrmann@caviumnetworks.com> <537B3A8E.70801@imgtec.com>
In-Reply-To: <537B3A8E.70801@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <penberg@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: penberg@iki.fi
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

On 05/20/2014 02:20 PM, James Hogan wrote:
> I don't know what Pekka's policy is for kvm tools, but to avoid
> confusion I'd like to make clear that this patchset depends on a KVM
> implementation (KVM_VM_TYPE==1 for VZ) which hasn't been accepted into
> the mainline kernel yet.

Is that something that is likely to end up in mainline Linux in one form 
or another? If yes, we can merge early like we did with arm64.

- Pekka

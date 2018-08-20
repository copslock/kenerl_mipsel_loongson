Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2018 19:14:26 +0200 (CEST)
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38161 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994693AbeHTROWXYhkL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2018 19:14:22 +0200
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D6D421CDD;
        Mon, 20 Aug 2018 13:14:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 20 Aug 2018 13:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=cPc3OEQD+PwVL5gxMEsN1/SeCH70uI+/bD9rJJeVh9k=; b=C6idfaOs
        wL9fkN58h6XMedniZ+no10RmhrroLGdI5FPd2NX7F+7njfuB1pJxJggEr3VaPWp4
        FAFf+GJCn32w7B7QVg0dZYWs298hUzQKTwLyt8fvriex7pAOTAMfB/vCjz1cmIza
        /LzVY3erm9nE0vdc74CImBonUpR1gpOyw/+FLDf6Y35HmFG3WkZG5VuzUYSS5xZd
        Rhfh8QnMUNlUqmo2lFPxlL2nKzLIy5piG0RDxk0PzArnwOAhRFnjYrVUnTE2sAgv
        PdV3x1c2I0+Klb3xPqG3/fKJRhZK9+tXO9bVqnLYI9Q+c1s/zY1Etcj6Mj6zuVwp
        QTOvChI7MKyl/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=cPc3OEQD+PwVL5gxMEsN1/SeCH70u
        I+/bD9rJJeVh9k=; b=KWtnEbyMepyUiXxSqscGxGyB8a1NYzUXsiLjTEcj2EOEG
        qkVEtLjYgZE33g3ADGo4fL89QpnWkyxd4GBKW7UQCuS7t+wtlb4GLRXCM50oQPcz
        iuYcw7JyelzthQWLlCfy9J7+Qlqi1MGYK72SrRNXWBG2nctsQCMu+ZIAEV6MP5e8
        GNa6Yvls38x2FbyzpNnfF25HJGBX7UnT+QpVTJDjERudn0kiOY4sntMCvcvFLr3K
        mRALWwlQRu/zbOhPpBVKiLP7fSSa6xsO6UsTYR2fZ/+byylCabt2ysuUuqnwCfUn
        1Q9rlxS2NTUCjQGo+Moy+MiQ8lxW7QAiQl0MqS3Cg==
X-ME-Proxy: <xmx:6_Z6W1SrsPyBoy74XXEYQ1-RczqDS2BBqlztFmtao-rs-MJNP7PoAg>
    <xmx:6_Z6W62_RPwev1bzKdfGn5vrubpwBK6Qww63JX7gUjOOz_SV2e6XXw>
    <xmx:6_Z6W3hZNxous2rbfa_nQbf7jmF1fc4u64_DQHtHmwg74pS0YOOP1A>
    <xmx:6_Z6WzUWvI-UHcQiEIJownx8YOIsvKzipD9G4i103RGqhI6DKpQ_9A>
    <xmx:6_Z6W-DMLdLsXOuub6pNmZKBW-OLSGQdcBcUFkXp5oFDAZDPMHDcPQ>
    <xmx:7PZ6W5ND-Swfs3kyRS4Sl0weHa_Qr5Qb-TuIvZNDZvB7lGO-il4wRQ>
X-ME-Sender: <xms:6_Z6W_QjSTil_gUZKosaZGp8zeoGKnKcYb1FqEump43F6fx8tZPTVQ>
Received: from localhost (5355525a.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.messagingengine.com (Postfix) with ESMTPA id D51C410292;
        Mon, 20 Aug 2018 13:14:18 -0400 (EDT)
Date:   Mon, 20 Aug 2018 19:14:16 +0200
From:   Greg KH <greg@kroah.com>
To:     Tobias Wolf <dev-NTEO@vplace.de>
Cc:     linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] MIPS: Fix memory reservation in bootmem_init for
 certain non-usermem setups
Message-ID: <20180820171416.GA18871@kroah.com>
References: <1983860.23LM468bU3@loki>
 <7994529.fS1YjVU6T6@loki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7994529.fS1YjVU6T6@loki>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65661
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

On Mon, Aug 20, 2018 at 01:10:38PM +0200, Tobias Wolf wrote:
> Commit 67a3ba25aa95 ("MIPS: Fix incorrect mem=X@Y handling") introduced a new
> issue for rt288x where "PHYS_OFFSET" is 0x0 but the calculated "ramstart" is
> not. As the prerequisite of custom memory map has been removed, this results
> in the full memory range of 0x0 - 0x8000000 to be marked as reserved for this
> platform.
> 
> This patch adds the originally intended prerequisite again.
> 
> Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
> ---
>  arch/mips/kernel/setup.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

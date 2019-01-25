Return-Path: <SRS0=1uEU=QB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D358DC282C2
	for <linux-mips@archiver.kernel.org>; Fri, 25 Jan 2019 07:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2C6218DE
	for <linux-mips@archiver.kernel.org>; Fri, 25 Jan 2019 07:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548402885;
	bh=//PP8S/LY58Bg9GGSquYoCuFT4++Vu0V2XMtrkXYNbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WgXL0Y8UHBTz8uFaKy7WRFzcB4TYn5mhiOs9UpdpwoNEqlxkVzUXQ6tsUvbO2nPDO
	 34sfkX+4ICN+oV2kHMzNJoqRfd9Z8QognkSsInPwACCftsckMMOBQSO/D2GTOhNl3A
	 GhT4zDZ2PLWuSQXWb5dFxHBS5KABkqymMX6pID0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfAYHyp (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:54:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfAYHyo (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 25 Jan 2019 02:54:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35792217D7;
        Fri, 25 Jan 2019 07:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548402883;
        bh=//PP8S/LY58Bg9GGSquYoCuFT4++Vu0V2XMtrkXYNbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jozMkjD9otEGuel2ihKLgCbDZbZCKC9opx+67xSdnMnhaF2VTt8NpZdcRR+UhJOBr
         Fbcj6JXcZpnq9vmeYga5MAjk2+ay/UJ/2RZCOxAmSi3y11BZ25MxVE1SoiFXssHHpk
         pgb78PB7zgqIdDs25ap6pZ0f2uHnaynJgR7cPELE=
Date:   Fri, 25 Jan 2019 08:54:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] MIPS: fix debugfs_simple_attr.cocci warnings
Message-ID: <20190125075441.GA14522@kroah.com>
References: <1548384137-171488-1-git-send-email-yuehaibing@huawei.com>
 <20190125071159.GA11891@kroah.com>
 <efbbf61d-0c4a-e7f6-8ce1-b5e6417afff1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efbbf61d-0c4a-e7f6-8ce1-b5e6417afff1@huawei.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Jan 25, 2019 at 03:43:21PM +0800, YueHaibing wrote:
> On 2019/1/25 15:11, Greg Kroah-Hartman wrote:
> > On Fri, Jan 25, 2019 at 02:42:17AM +0000, YueHaibing wrote:
> >> Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
> >> for debugfs files.
> >>
> >> Semantic patch information:
> >> Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
> >> imposes some significant overhead as compared to
> >> DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
> > 
> > What kind of overhead is this adding, and how are you measuring it?
> 
> The log message on the commit introducing the semantic patch says the
> following:
> 
> commit 5103068eaca2 ("debugfs, coccinelle: check for obsolete DEFINE_SIMPLE_ATTRIBUTE() usage")
> 
>     In order to protect against file removal races, debugfs files created via
>     debugfs_create_file() now get wrapped by a struct file_operations at their
>     opening.
> 
>     If the original struct file_operations are known to be safe against removal
>     races by themselves already, the proxy creation may be bypassed by creating
>     the files through debugfs_create_file_unsafe().
> 
>     In order to help debugfs users who use the common
>       DEFINE_SIMPLE_ATTRIBUTE() + debugfs_create_file()
>     idiom to transition to removal safe struct file_operations, the helper
>     macro DEFINE_DEBUGFS_ATTRIBUTE() has been introduced.
> 
>     Thus, the preferred strategy is to use
>       DEFINE_DEBUGFS_ATTRIBUTE() + debugfs_create_file_unsafe()
>     now.


That is true.  So, are you saying that you "know" when you remove these
files everything is safe?  Are you seeing some sort of problem with
these files as-is?  If not, why change them to the "unsafe" method?

thanks,

greg k-h

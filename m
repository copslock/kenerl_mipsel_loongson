Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Mar 2013 19:47:21 +0100 (CET)
Received: from mail-da0-f50.google.com ([209.85.210.50]:64942 "EHLO
        mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827456Ab3CBSrUFSqaX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Mar 2013 19:47:20 +0100
Received: by mail-da0-f50.google.com with SMTP id h15so1905521dan.37
        for <linux-mips@linux-mips.org>; Sat, 02 Mar 2013 10:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=EV01gA1C39QJJ65AwmTzOFZwy0yEXbtoOFqFtKctKzA=;
        b=F5hw6+rZN1vwY6Ub8oIARLNQjRJJzGgp1qCfaF7Jo4u00upB/d1Q781dh6LmvEQwBF
         182QYyEoamae5MSVdNMq7H10SXYSwnXLjx/H7K+WIyD8ExJ9Kl3eRGUtpDI527v6Jj3D
         XxCciZnwkPAgBC8GncuNLNSPJLvPATZYZjAn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=EV01gA1C39QJJ65AwmTzOFZwy0yEXbtoOFqFtKctKzA=;
        b=PoMVhFu7I97z6efkC50+vXIw5jxjC+yyDN1CgBSW6FMB/2MsW8SEoVFWLSfvk0J5nd
         yKmdyIakNLi0DuC3eONEcuL7keKm3DfAL/DwBYqlse8nvwTBLphl9kUi10ucaWrNlpGz
         SUKoojazkEeSgExf75e8TENK5Vl2zv9697xI0y2QzXqJyhJxaoeTfXuGzIMGCLzyKqOb
         WgRLQFrUeCCf1MKWXa1JhM6HSJMN7zcK2lQlb0ra2I9SiAevKGT5MPTJRk4dEjLCb89X
         0keuR1oOiGHCy2BbpxWRBCSQ54jE9PAZu/IVnieRwhcxQAsDF6Vmx618YNUVdOXlHAyQ
         Axzg==
X-Received: by 10.68.243.41 with SMTP id wv9mr21094195pbc.35.1362250033521;
        Sat, 02 Mar 2013 10:47:13 -0800 (PST)
Received: from localhost (67-148-102-249.dia.static.qwest.net. [67.148.102.249])
        by mx.google.com with ESMTPS id a10sm16281473pbq.29.2013.03.02.10.47.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 02 Mar 2013 10:47:12 -0800 (PST)
Date:   Sat, 2 Mar 2013 10:47:26 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     ganesanr@broadcom.com
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] Staging: Netlogic XLR/XLS GMAC driver
Message-ID: <20130302184726.GA2411@kroah.com>
References: <1362249374-25556-1-git-send-email-ganesanr@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1362249374-25556-1-git-send-email-ganesanr@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQmsjTG0nYU/unmmxXPQkoLys+me1tGTpwl0nO6RO/MtjrY71tX2eE8Fj1jQ4bIVpo2NaOBT
X-archive-position: 35835
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Mar 03, 2013 at 12:06:13AM +0530, ganesanr@broadcom.com wrote:
> From: Ganesan Ramalingam <ganesanr@broadcom.com>
> 
> Add support for the Network Accelerator Engine on Netlogic XLR/XLS
> MIPS SoCs. The XLR/XLS NAE blocks can be configured as one 10G
> interface or four 1G interfaces. This driver supports blocks
> with 1G ports.
> 
> Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
> ---
>  This patch has to be merged via staging tree.

Why is this a staging driver?

I need a TODO file listing the remaining things left to fix up in this
driver to get it merged to the "correct" location in the kernel, along
with some email addresses and names of who to send the patches to for
review, before I can accept this.

thanks,

greg k-h

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2009 22:12:58 +0200 (CEST)
Received: from smtp-out.google.com ([216.239.33.17]:61950 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S2097378AbZIRUMu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Sep 2009 22:12:50 +0200
Received: from spaceape10.eur.corp.google.com (spaceape10.eur.corp.google.com [172.28.16.144])
	by smtp-out.google.com with ESMTP id n8IK8SBx029820;
	Fri, 18 Sep 2009 21:08:29 +0100
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1253304622; bh=wXY/xbSoeKeP/UnNPC5kfD6E6T0=;
	h=DomainKey-Signature:Date:From:X-X-Sender:To:cc:Subject:
	 In-Reply-To:Message-ID:References:User-Agent:MIME-Version:
	 Content-Type:X-System-Of-Record; b=b5jjV2xZcvLojoKs5XwUbncRdSrjpOH
	qj2fA94tirxKST/n6Jkac6W7Ijs1CEtI0bBCAEVr7BnDz6DFh1IgMQA==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:
	references:user-agent:mime-version:content-type:x-system-of-record;
	b=M5moPOQwk+gcOMMEZQv+1U+vlkgf2t48QGXUQbZfSG0CYyBMvo/fLnI+wa9DqGuwY
	weCOo/azhiDHv98jvPSzg==
Received: from pzk41 (pzk41.prod.google.com [10.243.19.169])
	by spaceape10.eur.corp.google.com with ESMTP id n8IK8Pbr014019;
	Fri, 18 Sep 2009 13:08:26 -0700
Received: by pzk41 with SMTP id 41so925541pzk.4
        for <multiple recipients>; Fri, 18 Sep 2009 13:08:25 -0700 (PDT)
Received: by 10.114.242.5 with SMTP id p5mr3091656wah.66.1253304503603;
        Fri, 18 Sep 2009 13:08:23 -0700 (PDT)
Received: from chino.kir.corp.google.com (chino.kir.corp.google.com [172.31.12.59])
        by mx.google.com with ESMTPS id 22sm661834pzk.10.2009.09.18.13.08.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Sep 2009 13:08:23 -0700 (PDT)
Date:	Fri, 18 Sep 2009 13:08:22 -0700 (PDT)
From:	David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:	Eric B Munson <ebmunson@us.ibm.com>
cc:	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, rdunlap@xenotime.net,
	michael@ellerman.id.au, ralf@linux-mips.org, wli@holomorphy.com,
	mel@csn.ul.ie, dhowells@redhat.com, arnd@arndb.de,
	fengguang.wu@intel.com, shuber2@gmail.com,
	hugh.dickins@tiscali.co.uk, zohar@us.ibm.com, hugh@veritas.com,
	mtk.manpages@gmail.com, chris@zankel.net,
	linux-man@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-mips@linux-mips.org,
	linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/7] Add MAP_HUGETLB for mmaping pseudo-anonymous huge
 page regions
In-Reply-To: <08251014d2eb30e9016bab16404133f5c13beacf.1253272709.git.ebmunson@us.ibm.com>
Message-ID: <alpine.DEB.1.00.0909181308110.27556@chino.kir.corp.google.com>
References: <cover.1253272709.git.ebmunson@us.ibm.com> <653aa659fd7970f7428f4eb41fa10693064e4daf.1253272709.git.ebmunson@us.ibm.com> <08251014d2eb30e9016bab16404133f5c13beacf.1253272709.git.ebmunson@us.ibm.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-System-Of-Record: true
Return-Path: <rientjes@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
Precedence: bulk
X-list: linux-mips

On Fri, 18 Sep 2009, Eric B Munson wrote:

> This patch adds a flag for mmap that will be used to request a huge
> page region that will look like anonymous memory to user space.  This
> is accomplished by using a file on the internal vfsmount.  MAP_HUGETLB
> is a modifier of MAP_ANONYMOUS and so must be specified with it.  The
> region will behave the same as a MAP_ANONYMOUS region using small pages.
> 
> Signed-off-by: Eric B Munson <ebmunson@us.ibm.com>

Acked-by: David Rientjes <rientjes@google.com>

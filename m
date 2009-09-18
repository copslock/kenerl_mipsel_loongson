Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2009 22:11:35 +0200 (CEST)
Received: from smtp-out.google.com ([216.239.33.17]:61522 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S2097375AbZIRUL2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Sep 2009 22:11:28 +0200
Received: from spaceape9.eur.corp.google.com (spaceape9.eur.corp.google.com [172.28.16.143])
	by smtp-out.google.com with ESMTP id n8IK75tE030534;
	Fri, 18 Sep 2009 21:07:07 +0100
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1253304537; bh=a9u8/sl/HzTGw1crlweuy9VAk6Q=;
	h=DomainKey-Signature:Date:From:X-X-Sender:To:cc:Subject:
	 In-Reply-To:Message-ID:References:User-Agent:MIME-Version:
	 Content-Type:X-System-Of-Record; b=G963yvRsZsKmZUX2/8X6F1ln8A4BEho
	6K+/wHv7BvrnySp+b+/MHlZX7AqHZ8lkcuQ7uxhbtOVcJWsTMgV5heQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:
	references:user-agent:mime-version:content-type:x-system-of-record;
	b=SK+6RYKM6CWCyX7+34nyjHaVulT8j++2YFog35khPxfnXcLLQfFej3IFgcUJcserp
	23CkfsBvDIZlVX3V72ygw==
Received: from pzk28 (pzk28.prod.google.com [10.243.19.156])
	by spaceape9.eur.corp.google.com with ESMTP id n8IK6kZr005078;
	Fri, 18 Sep 2009 13:07:03 -0700
Received: by pzk28 with SMTP id 28so1070873pzk.5
        for <multiple recipients>; Fri, 18 Sep 2009 13:07:02 -0700 (PDT)
Received: by 10.114.19.30 with SMTP id 30mr3057868was.134.1253304422371;
        Fri, 18 Sep 2009 13:07:02 -0700 (PDT)
Received: from chino.kir.corp.google.com (chino.kir.corp.google.com [172.31.12.59])
        by mx.google.com with ESMTPS id 22sm658830pzk.14.2009.09.18.13.07.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Sep 2009 13:07:01 -0700 (PDT)
Date:	Fri, 18 Sep 2009 13:06:59 -0700 (PDT)
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
Subject: Re: [PATCH 1/7] hugetlbfs: Allow the creation of files suitable for
 MAP_PRIVATE on the vfs internal mount
In-Reply-To: <0f28cb0d89a7b83f7edf92181c5d13422f5b009c.1253276847.git.ebmunson@us.ibm.com>
Message-ID: <alpine.DEB.1.00.0909181306450.27556@chino.kir.corp.google.com>
References: <653aa659fd7970f7428f4eb41fa10693064e4daf.1253272709.git.ebmunson@us.ibm.com> <0f28cb0d89a7b83f7edf92181c5d13422f5b009c.1253276847.git.ebmunson@us.ibm.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-System-Of-Record: true
Return-Path: <rientjes@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
Precedence: bulk
X-list: linux-mips

On Fri, 18 Sep 2009, Eric B Munson wrote:

> There are two means of creating mappings backed by huge pages:
> 
>         1. mmap() a file created on hugetlbfs
>         2. Use shm which creates a file on an internal mount which essentially
>            maps it MAP_SHARED
> 
> The internal mount is only used for shared mappings but there is very
> little that stops it being used for private mappings. This patch extends
> hugetlbfs_file_setup() to deal with the creation of files that will be
> mapped MAP_PRIVATE on the internal hugetlbfs mount. This extended API is
> used in a subsequent patch to implement the MAP_HUGETLB mmap() flag.
> 
> Signed-off-by: Eric Munson <ebmunson@us.ibm.com>

Acked-by: David Rientjes <rientjes@google.com>

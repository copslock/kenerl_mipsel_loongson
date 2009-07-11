Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Jul 2009 05:15:12 +0200 (CEST)
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491955AbZGKDPF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 11 Jul 2009 05:15:05 +0200
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 39BF427977;
	Fri, 10 Jul 2009 23:14:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 45B4C27976; Fri,
 10 Jul 2009 23:14:52 -0400 (EDT)
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Chris Dearman <chris@mips.com>,
	Shinya Kuribayashi <shinya.kuribayashi@necel.com>,
	yuasa@linux-mips.org, linux-mips@linux-mips.org,
	git@vger.kernel.org
Subject: Re: What's happening with vr41xx_giu.c?
References: <4A5680B5.2090405@necel.com> <4A56B060.7090106@mips.com>
 <20090710104743.GB1288@linux-mips.org>
 <7vhbxkv7ax.fsf@alter.siamese.dyndns.org>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Fri, 10 Jul 2009 20:14:50 -0700
In-Reply-To: <7vhbxkv7ax.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 10 Jul 2009 09\:20\:22 -0700")
Message-ID: <7vk52frjv9.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: 0418617A-6DC9-11DE-80C8-424D1A496417-77302942!a-sasl-quonix.pobox.com
Return-Path: <gitster@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gitster@pobox.com
Precedence: bulk
X-list: linux-mips

Junio C Hamano <gitster@pobox.com> writes:

> We _could_ add -E option to "git apply" and pass that through "git am" to
> support projects like the kernel where 0-byte files are forbidden.  A
> patch to do that shouldn't be too involved.

I ended up doing something a bit more useful.  A two-patch series follows
shortly.

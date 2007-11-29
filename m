Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2007 22:51:17 +0000 (GMT)
Received: from mx01.hansenet.de ([213.191.73.25]:12470 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S28576967AbXK2WvI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Nov 2007 22:51:08 +0000
Received: from [213.39.153.23] (213.39.153.23) by webmail.hansenet.de (7.3.118.12) (authenticated as mbx20228207@koeller-hh.org)
        id 4746DA5100E125B8; Thu, 29 Nov 2007 23:47:52 +0100
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id 2FF4C47AD2;
	Thu, 29 Nov 2007 23:47:56 +0100 (CET)
From:	Thomas Koeller <thomas@koeller.dyndns.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: git problem
Date:	Thu, 29 Nov 2007 23:47:55 +0100
User-Agent: KMail/1.9.7
Cc:	linux-mips@linux-mips.org
References: <200711281950.46472.thomas@koeller.dyndns.org> <474EA356.3070303@gmail.com>
In-Reply-To: <474EA356.3070303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711292347.55979.thomas@koeller.dyndns.org>
Return-Path: <thomas@koeller.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@koeller.dyndns.org
Precedence: bulk
X-list: linux-mips

On Donnerstag, 29. November 2007, Franck Bui-Huu wrote:
> Thomas Koeller wrote:
> > The commit is of course present in both trees. AFAIK the
> > 'cannot describe' error shows if there are no tags at all,
> > but this is not the case; .git/refs/tags is fully populated.
>
> Not really, it can happen if the commit you're trying to describe and
> all of its parents are not tagged.
Yes, that is what I meant to say.

> Is the commit originally part of Linus' tree and was pulled later by
> Ralf ?
Indeed.

>
> If so, it probably means that the commits committed by Ralf in his
> tree, which are the tagged ones, have no relationship with the ones
> pulled from Linus.
So far it has been my understanding that if I pull from a remote
repository, all the commits are merged into the target branch,
resulting in a combined history containing all my commits as well as
those pulled. This means that as long as any (locally created or
pulled) commit preceeding the one that git-describe is applied to
is tagged, I would expect git-describe to find that tag. This seems
to be a misconception, then?

Thomas



-- 
Thomas Koeller
thomas@koeller.dyndns.org

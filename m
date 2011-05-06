Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2011 12:07:41 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:37477 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491019Ab1EFKHi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2011 12:07:38 +0200
Received: by ewy3 with SMTP id 3so1028628ewy.36
        for <multiple recipients>; Fri, 06 May 2011 03:07:31 -0700 (PDT)
Received: by 10.213.110.18 with SMTP id l18mr780567ebp.57.1304676451616;
        Fri, 06 May 2011 03:07:31 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.96.47])
        by mx.google.com with ESMTPS id 46sm1196579ees.11.2011.05.06.03.07.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 May 2011 03:07:27 -0700 (PDT)
Message-ID: <4DC3C7FC.9050807@mvista.com>
Date:   Fri, 06 May 2011 14:05:48 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/6] of: Make of_find_node_by_path() traverse /aliases
 for relative paths.
References: <1304614949-30460-1-git-send-email-ddaney@caviumnetworks.com> <1304614949-30460-3-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1304614949-30460-3-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 05-05-2011 21:02, David Daney wrote:

> Currently all paths passed to of_find_node_by_path() must begin with a
> '/', indicating a full path to the desired node.

> Augment the look-up code so that if a path does *not* begin with '/',
> the path is used as the name of an /aliases property.  The value of
> this alias is then used as the full node path to be found.

> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
> ---
>   drivers/of/base.c |   41 ++++++++++++++++++++++++++++++++++++++++-
>   1 files changed, 40 insertions(+), 1 deletions(-)

> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 632ebae..1a0a83e 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
[...]
> @@ -348,14 +351,50 @@ EXPORT_SYMBOL(of_get_next_child);
>   struct device_node *of_find_node_by_path(const char *path)
>   {
>   	struct device_node *np = allnodes;
> +	struct device_node *aliases = NULL;
> +	char *alias = NULL;
> +	char *new_path = NULL;
>
>   	read_lock(&devtree_lock);
> +
> +	if (path[0] != '/') {
> +		const char *ps;
> +		aliases = of_find_node_by_path("/aliases");
> +		if (!aliases)
> +			goto out;
> +
> +		ps = strchr(path, '/');
> +		if (ps) {
> +			size_t len = ps - path;
> +			alias = kmalloc(len + 1, GFP_KERNEL);

    How about error handling?

> +			strncpy(alias, path, len);
> +			alias[len] = 0;
> +			path = of_get_property(aliases, alias, NULL);
> +			if (!path)
> +				goto out;
> +			len = strlen(path) + strlen(ps) + 1;
> +			new_path = kmalloc(len, GFP_KERNEL);

    Here too...

WBR, Sergei

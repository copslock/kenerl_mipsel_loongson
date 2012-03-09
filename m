Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2012 02:33:42 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:46589 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903692Ab2CIBdd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2012 02:33:33 +0100
Received: by iaky10 with SMTP id y10so1866009iak.36
        for <linux-mips@linux-mips.org>; Thu, 08 Mar 2012 17:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=w0rlf8839gitIxtqSw1lIosDGI82MZLGqFfeJaw73ck=;
        b=d4iDv+XFgZB8n+i4Zprf8GjaRalrulDguiEwI8vnInamXFg8H60OSq79ihdxZ+Z7Oq
         I30eAZl0zIONw1Ri+hB+RlzZXwp7SyX+wFo27uQXe9XAVlShAwMnobAXM8MdlF/nLKLg
         MH+20+VPk2V+9tWV6prUCnv5Hsyx5cvPoFUBbQQfa9qBDcTy+//wr4QtRWeeM8S5pYae
         23UwLbC2nRtPt3lLhu6U5AeOl8eta61a0FymyTZzJSZib/phIftZ8R+k7asRh0/HXAi8
         DxFT3ok1daJxqyw5sX4/xwpUoyYEAx+wdTOMaW+OOIqKi7qy0DdOMs5SmsBcJm1Yxvns
         Wdiw==
Received: by 10.50.194.233 with SMTP id hz9mr27377igc.11.1331256806924;
        Thu, 08 Mar 2012 17:33:26 -0800 (PST)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id pr8sm365115igb.6.2012.03.08.17.33.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 17:33:25 -0800 (PST)
Received: by localhost (Postfix, from userid 1000)
        id 64DF53E0901; Thu,  8 Mar 2012 18:33:24 -0700 (MST)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v6 2/2] of: Make of_find_node_by_path() traverse /aliases for relative paths.
To:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
In-Reply-To: <1330543264-18103-3-git-send-email-ddaney.cavm@gmail.com>
References: <1330543264-18103-1-git-send-email-ddaney.cavm@gmail.com> <1330543264-18103-3-git-send-email-ddaney.cavm@gmail.com>
Date:   Thu, 08 Mar 2012 18:33:24 -0700
Message-Id: <20120309013324.64DF53E0901@localhost>
X-Gm-Message-State: ALoCoQk2FWc2wsBkoCwGB23aCj4G7Fs6c17+BZ+wRxUoAi7SdSEVa0hdL0kmsj0epJhIuWyXIN3b
X-archive-position: 32621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 29 Feb 2012 11:21:04 -0800, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Currently all paths passed to of_find_node_by_path() must begin with a
> '/', indicating a full path to the desired node.
> 
> Augment the look-up code so that if a path does *not* begin with '/',
> the path is used as the name of an /aliases property.  The value of
> this alias is then used as the full node path to be found.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/of/base.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 62 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 5806449..0bbe47c 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -365,22 +365,81 @@ EXPORT_SYMBOL(of_get_next_child);
>  
>  /**
>   *	of_find_node_by_path - Find a node matching a full OF path
> - *	@path:	The full path to match
> + *	@path: Either the full path to match, or if the path does not
> + *	       start with '/', the name of a property of the /aliases
> + *	       node (an alias).  In the case of an alias, the node
> + *	       matching the alias' value will be returned.
>   *
>   *	Returns a node pointer with refcount incremented, use
>   *	of_node_put() on it when done.
>   */
>  struct device_node *of_find_node_by_path(const char *path)
>  {
> -	struct device_node *np = allnodes;
> +	struct device_node *np = NULL;
> +	struct device_node *aliases = NULL;
> +	char *alias = NULL;
> +	char *new_path = NULL;
> +	char *ps;
>  
>  	read_lock(&devtree_lock);
> -	for (; np; np = np->allnext) {
> +
> +	/*
> +	 * The following code has three possibilities:
> +	 * 1) '/' at start of string; path == ps; (based at root)
> +	 * 2) '/' at offset in string; path < ps; (relative to alias)
> +	 * 3) '/' not found; ps == NULL; (alias only)
> +	 *
> +	 * If ps != path, then it is either a pure alias (ps == NULL),
> +	 * or an alias with a relative path (path < ps).  Either way,
> +	 * look up the path pointed to by the alias.
> +	 */
> +	ps = strchr(path, '/');
> +	if (path != ps) {
> +		aliases = of_find_node_by_path("/aliases");
> +		if (!aliases)
> +			goto out;
> +
> +		/*
> +		 * Duplicate the alias part of the string so it can be
> +		 * NULL terminated.
> +		 */
> +		alias = kstrndup(path,
> +				 ps ? (ps - path) : strlen(path), GFP_KERNEL);
> +		if (!alias)
> +			goto out;
> +		path = of_get_property(aliases, alias, NULL);
> +		if (!path || path[0] != '/')
> +			goto out;

All the aliases are already decoded at boot time now.  See
of_alias_scan().  Instead of open-coding this, you can add an
of_alias_lookup() function something like this (untested):

const char *of_alias_lookup(const char *alias)
{
	struct alias_prop *app;
	list_for_each_entry(app, &aliases_lookup, link) {
		if (strcmp(app->alias, alias))
			return app->np->full_name;
	}
	return NULL;
}

Then most of the above code disappears.  It can instead look like:

	ps = strchr(path, '/');
	if (path != ps) {
		char alias[ps - path + 1];
		strncpy(alias, path, ps - path);
		alias[ps - path] = '\0';
		path = of_alias_lookup(alias);
		if (path && ps)
			/* Don't forget to free this */
			path = kasprintf(GFP_KERNEL, "%s%s", path, ps);
		if (!path)
			return NULL;
	}

g.

> +
> +		/* If ps is not NULL, then there is a relative path to append */
> +		if (ps) {
> +			new_path = kzalloc(strlen(path) + strlen(ps) + 1,
> +					   GFP_KERNEL);
> +			if (!new_path)
> +				goto out;
> +
> +			sprintf(new_path, "%s%s", path, ps);
> +			path = new_path;
> +		}
> +	}
> +
> +	/*
> +	 * At this point, path now points to the full unaliased path
> +	 * to a node, regardless of whether or not it started with an
> +	 * alias.
> +	 */
> +
> +	for (np = allnodes; np; np = np->allnext) {
>  		if (np->full_name && (of_node_cmp(np->full_name, path) == 0)
>  		    && of_node_get(np))
>  			break;
>  	}
> +out:
> +	if (aliases)
> +		of_node_put(aliases);
>  	read_unlock(&devtree_lock);
> +	kfree(alias);
> +	kfree(new_path);
>  	return np;
>  }
>  EXPORT_SYMBOL(of_find_node_by_path);
> -- 
> 1.7.2.3
> 

-- 
email sent from notmuch.vim plugin

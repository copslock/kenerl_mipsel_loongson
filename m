Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jul 2004 01:28:36 +0100 (BST)
Received: from xxx.arxiv.cornell.edu ([IPv6:::ffff:132.236.180.11]:26303 "EHLO
	xxx.arxiv.cornell.edu") by linux-mips.org with ESMTP
	id <S8225195AbUGCA23>; Sat, 3 Jul 2004 01:28:29 +0100
Received: (from e-prints@localhost)
	by xxx.arxiv.cornell.edu (8.11.6/x.x.x) id i630SOp10111;
	Fri, 2 Jul 2004 20:28:24 -0400
Date: Fri, 2 Jul 2004 20:28:24 -0400
Message-Id: <200407030028.i630SOp10111@xxx.arxiv.cornell.edu>
Precedence: bulk
X-Note: e-print arXiv software written by PG at LANL (8/91,...,4/99)
X-Supported-By: U.S. National Science Foundation, Agreement 0132355 (7/01-6/04)
From: no-reply@arXiv.org (send mail ONLY to cond-mat)
Reply-To: cond-mat@arXiv.org
To: linux-mips@linux-mips.org
Subject: RE: Hello
Return-Path: <no-reply@arXiv.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: no-reply@arXiv.org
Precedence: bulk
X-list: linux-mips

       cond-mat@arXiv.org is a fully automated e-print archive for 
           condensed matter preprints (starting from April, 1992)

The list of subject classes within cond-mat is:

  Disordered Systems and Neural Networks,
  Materials Science (the mtrl-th archive has been moved into cond-mat),
  Mesoscopic Systems and Quantum Hall Effect,
  Soft Condensed Matter,
  Statistical Mechanics,
  Strongly Correlated Electrons,
  Superconductivity (the supr-con archive has been  moved into cond-mat)

(From  Nov, 1994 though September 1996, there were also archives
 mtrl-th for materials theory, and supr-con for superconductivity.)


To communicate with the archive via e-mail, send messages to
                     cond-mat@arXiv.org
WorldWideWeb access is available via  "http://arXiv.org/"
Anonymous ftp access is available via arXiv.org

-------------------------------------------------------------------------
-------------------------------------------------------------------------
     In the generic arXiv help text, substitute cond-mat@arXiv.org
         for the generic e-mail address arch-ive@arXiv.org
-------------------------------------------------------------------------
-------------------------------------------------------------------------

Outgoing mail from the e-print archive has the username no-reply
(to avoid problems due to occasional mail that bounces back).
Commands to the system should always be sent to arch-ive@arXiv.org
with the command in the subject field (e.g.  Subject: help).
Only one command at a time is accepted. Subscribers automatically
receive a listing of new titles/abstracts on days papers are received.

You will have a more pleasurable time using the archives if you read this
file carefully, read ALL responses you get to your interactions
with the archives, and follow the instructions therein.

This help file summarizes the email interface commands.

This information can be more easily accessed via the WorldWideWeb
at http://arXiv.org/help/ .

==========================================================================
Additional help is available by using the `get' command to retrieve the
following files:

(this file):    summary of e-mail commands

prep.txt:       how to prepare your abstract and paper for submission

submit.txt:     instructions for submitting to the archive

eput.txt:       instructions for e-mail submissions,
                including appraisal of different packaging formats

fput.txt:       how to use anonymous ftp to put and replace papers

utilities.txt:  utilities and applications to install for use
                with the archives, and where to find them for many platforms

sizes.txt:      how to slim down your PostScript files

==========================================================================

Summary of Commands for the e-Mail Interface:

All commands to arch-ive@xxx may be abbreviated by any truncation that includes
at least the first three letters (e.g. rep, sub, can, dis, lis, com, ...).
(The term arch-ive a generic one; substitute an appropriate archive name like
hep-th when actually doing something). The command must be given in the 
subject field (e.g., Subject: help ).


Commands for retrieving information
    (get, cget, uget, list, find, distribution):

  get <paper#>  <macroname>

    Returns paper specified by paper# (e.g. `get 9109001'), or macro specified
    by macroname.
    For abstracts alone, append .abs to the paper# (e.g. `get 9109001.abs').
    Multiple requests in one `get' are allowed and preferred.
    For example, `get 3 2.abs 9108001' returns multiple papers and abstracts.
    get defaults to the current year/month so that during 10/91,
    `get 1 2 5' or `get 01 2 005' will automatically prepend 9110's and the
    necessary zeroes to result in `get 9110001 9110002 9110005'.
    Numbers too large for the current year/month will have the previous
    year/month prepended. get also defaults to the current year, e.g.
    `get 9005' during  1995 gives `get 9509005', and months/numbers too big
    for the current year default to the previous year.
    You can freely mix formats, as in `get 1 08005 harvmac.tex 9109058 2.abs'.

    As of 1 Jan 1996, the get command returns a single uuencoded, gzipped,
    tar archive containing all files in a submission (except in the case
    of a submission consisting of a single file [e.g. TeX, PS, or PDF],
    which is instead just gzipped [i.e. not tarred] and uuencoded for e-mail).
    For utilities to unpack these, read utilities.txt
    (available via `get utilities.txt'). For those unable to process this new
    format, there is now the `uget' command.
    
  cget <paper#>

    Same as the get command, but the file is cut into multiple parts
    of size < 100 kB (195 blocks) to accommodate certain capricious
    or limited mail routers and to speed bitnet transmission.

  uget <paper#>

    Same as the get command, but files are unpacked from our storage
    format (gzipped tar files) and sent out individually. Meant for those
    unable to adapt to our new (1 Jan 1996) packaging. Users should feel
    encouraged to modernize to use gzip and tar (see utilities.txt
    for more info, including cross-platform availability) in order to use
    the normal get command.

  listing

    Returns list of year/month's currently available

  list <yymm's  macros  new  pastweek>

    Returns title/author's of papers currently held for given year/month
      subset, e.g. `list 9109'.
    `list macros' returns a list of the available TeX macros and various
      utilities such as reform and uufiles.
    `list new' resends the most recently sent title/abstract listing
      of papers received (typically from the previous day).
    `list pastweek' returns past week of title/author listings.
    For title/author/abstract's of papers held for given yr/mo subsets,
       append .abs: e.g.    `list 9109.abs 9110.abs'
    multiple requests allowed: e.g. `list 9109 9110.abs macros new pastweek'

  clist <yymm.abs ...>

    Same as the list command, but files are cut into multiple parts
    of size < 100 kB (195 blocks) to accommodate certain capricious
    or limited mail routers and to speed bitnet transmission.

  find <search-string>

    Searches the title/author list for search-string (either author or word in
    title, case insensitive) to retrieve paper number, e.g. `find goldstone'.
    Find defaults to the past 12 months, so for earlier years use e.g.
    `find goldstone 91'.

  distribution <name>

    Search for `name' in e-mail distribution list.


Commands for submitting information:
    (put, fput, replace, freplace, figures, add, cross, published)

  put

    Submit a paper (body of the message must be in the format
    described in prep.txt, available via `get prep.txt').
    Paper will be assigned a paper number, and added to the listings
    (do not `put'  the same paper to more than one e-print archive, instead use
    the `cross' command to cross list the paper). Never `put' the same
    paper twice. Instead use the `replace' command.
    The preferred format for `put' is TeX/LaTeX source. Please don't submit
    PostScript generated from TeX. We have an automatic TeX'ing script on-line
    that will generate PostScript from your TeX source. As of
    1 Jan 1996, all submissions are tested for automatic PostScript generation
    before they can be entered into the archives.
    See neworder.txt for more info.

  fput <filename1 ... filenameN>

    Submit a paper using ftp. First transfer files (filename1 ...) for
    paper via anonymous ftp to arXiv.org's /incoming ftp directory.
    Body of `fput' e-mail message is in same format as that of `put' command
    (i.e.  title/author and abstract fields delimited by \\'s), as described
    in prep.txt, but nothing need follow the final \\
    terminating the abstract. It is advisable to read the complete fput help
    before using (available via `get fput.txt' ).

  replace <paper#>

    Replace a paper specified by paper# with a revised version (only
    original submitter can do this, from the original e-mail account).
    The paper should be resubmitted in the same format as for the
    `put' command. Be sure to include the full abstract, since this is
    replaced as well, although it won't appear in the daily mailing
    (unless the `replace' is on the same day as the `put').
    The Comments: field (i.e. after Title: and Authors: ) should contain a
    short comment describing the severity of the changes so that others
    can determine if it is worth their time to get your paper again.
    Remember to include your original Comments: as well, because the
    replacement wipes these out, and
    the original comments still contain useful information.
    Any cross-listed entries, e.g. hep-ph/9204201 already cross-listed to
    hep-th, are automatically replaced, e.g. on hep-th,  when you replace
    hep-ph/9204201 on hep-ph -- additional action is no longer necessary.

    You must resend all files contained in your submission. You can only
    replace your entire submission. There is no way to replace only part
    of it (e.g. a single figure).

    In addition, replacements are subject to the same test for automatic
    processing as for puts.
    As of 1 Jan 1996, the text of the original submission is retained
    if it is replaced after the first day (i.e, if it has already appeared in a
    newlistings mailing). This is to prevent excessive backdating of content.
    (The original submissions are not currently publicly available, but
    will probably be made so at some later date.)
    If you are replacing a paper to update the results because of subsequent
    work by others, we require that you exercise professional
    courtesy and refer to this work, preferably in the Comments: field.
    (This avoids sticky priority disputes.)
    The replace command can be used to withdraw a paper from the archives.
    You cannot completely remove a paper that has appeared in a mailing;
    you can only replace it with a statement that it is withdrawn.

  freplace <paper#> <filename1 ... filenameN>

    Submit a replacement using anonymous ftp, where filename1 ... have
    already been deposited to arXiv.org's /incoming ftp directory.
    The paper number must be the FIRST argument.
    The body of an `freplace' message is the same as that for `fput'.
    Remember to include the full abstract.
    It is advisable to  read the complete `fput/freplace' help before using
    (available via `get fput.txt'). The caveats for the replace command
     apply here as well.

  figures <paper#>

    This command is now obsolete (1 Jan '96). All files should be sent in a
    single package. See eput.txt for more info.

  add <paper#>

    This command is now obsolete (1 Jan '96). If your mailer imposes size
    limits on outgoing mail, than you must use fput or freplace.

  cross <arch-ive/paper#>

    Cross-list paper from another e-print archive. e.g.
     a) first put paper To: hep-ph@arXiv.org which assigns it hep-ph/9204201
     b) wait until you see your paper listing in the next daily mailing.
        This is important because paper numbers are not permanent until then.
     c) then send an e-mail message (with blank message body)
                  To: astro-ph@arXiv.org
             Subject: cross hep-ph/9204201
        so that the hep-ph entry will appear as well on astro-ph.
       (NOTE: In the above case of a paper originally submitted to hep-ph,
        obviously do not send the cross-list command To: hep-ph@arXiv.org .)
    Generates abstract entry for daily listings and for access
    by `find' and `list' commands. Cross-listed papers must be obtained
    directly from the archive where the paper was originally submitted (i.e.
    hep-ph in example above).
       To cross-list to an archive that allows (or requires) subject classes,
       include your desired subject class at the end of the cross command, e.g.
                  To: physics@arXiv.org
             Subject: cross hep-th/9611010 Mathematical Methods in Physics
        This can also be used to cross-list submissions to different
       subject classes within an archive, e.g., for a submission originally
       submitted to the cond-mat archive with Subj-class: Materials Science,
                  To: cond-mat@arXiv.org
             Subject: cross cond-mat/9611010 Superconductivty
       will add Superconductivity as a secondary subject class.
    Note that cross-listings should not be abused and inappropriate crosses 
    will be removed.

  published <paper#> <reference>

    Adds a Journal reference to paper's entry, accessible via `find', `list',
    `list [].abs', `get [].abs' commands;
     e.g.,    `published 9107001 Rec. Jnl. 180 (1992) 101'.
    Journal-ref's should be complete bibliographic references, i.e. they
    should include the journal name, volume, year, and page number. Anything
    short of this belongs in the Comments: field.


Subscription commands
    (subscribe, cancel, subscribe all, cancel all):

  subscribe <your full name>

    Add new username to daily distribution list (e-mail address will
    automatically be extracted from return address), `your full name'
    is your full name (any number of words and initials) as you wish
    it to appear on the distribution list. <<<Note: `suscribe' is not
    a word>>> (It is of course no longer obvious why people subscribe
    for intrusive e-mail receipt of abstracts when they have www
    access on-demand from http://arXiv.org/ ). e-Mail addresses that
    bounce three consecutive times are automatically cancelled. If you do
    not receive a response to your `subscribe' message, it is most likely
    because your mailer is misconfigured and the return address in the
    From: line or Reply-To: line is broken. We have no way of contacting you
    if this is the case, so you are on your own to figure out what is wrong.

  cancel

    Remove user@nodename from daily distribution list. The e-mail address is
    extracted automatically, so cancel message must be sent from the same
    account as originally used to subscribe.
    Note that you may be subscribed instead through a remote listserv,
    or through some local preprint distribution list at your end.
    You can determine the origin of your subscription by examining the
    the header from the daily mailing you receive.
    If you no longer have access to your original subscription account,
    the administrators at arXiv.org may be able to cancel it for you.
    Send request as a comment, and be certain to
    to include the entire header of a daily abstract mailing that you have
    received so that we can determine how you are subscribed. (Do not send
    a useless header from the failed `cancel' or from a `get', etc.)

  subscribe all <password>

    Receive daily list of changes to database. The list of changes comes
    formatted in a form suitable for automated ftp scripts. The password
    will be added to the Subject: line of the daily message so that
    automated scripts can be reasonably sure that the messages are authentic.
    Don't use your account password. If you do not include a password
    then a random one will automatically be generated for you.

  cancel all

    Cancel previously entered `subscribe all'  (i.e. in order to no longer
    receive daily list of changes to database). `cancel all' will not
    cancel a regular subscription (one that sends you the complete abstracts
    each day). You must use the `cancel' command for
    each individual archive to which you are subscribed.


Miscellaneous commands
          (comment, help):

  comment

    Forward message for human perusal. If you have any doubts about
    how to submit something or where it should go, you can use this
    command to ask questions. They are usually answered on a one day
    turn around, often sooner. Style files of use to other authors
    can also be sent in, along with a one-line description of the style.

  help

    Returns this file.


---------------------------------------------------------------------

Do not make multiple requests for the same paper. If you receive nothing
(or if the response is slow) it means there is a problem at your end.

Anonymous ftp for getting and retrieving files is enabled on arXiv.org.
use   login: anonymous
      password: yourusername

  The relevant directories are  listings  and  papers  (the latter has
  subdirectories 9108, 9109, ...  ). If you are not already familiar with
  anonymous ftp, this is not a good place to practice.
  Papers can be put on the archives via anonymous ftp using `fput' and
  `freplace' (see above,  or `get fput.txt' for further info).

For european users, many of these databases are mirrored as
the equivalent arch-ive@babbage.sissa.it, which allows access both via the
above e-mail requests and via anonymous ftp.

WorldWideWeb access is available via  http://arXiv.org/
and other mirror sites worldwide

Some other e-print archives running the same software:

Physics
hep-th@arXiv.org             High Energy Physics - Theory, 8/91
hep-lat@arXiv.org            High Energy Physics - Lattice, 2/92
hep-ph@arXiv.org             High Energy Physics - Phenomenology, 3/92
astro-ph@arXiv.org           Astrophysics, 4/92
cond-mat@arXiv.org           Condensed Matter, 4/92
gr-qc@arXiv.org              General Relativity and Quantum Cosmology, 7/92
nucl-th@arXiv.org            Nuclear Theory, 10/92
chem-ph@arXiv.org            Chemical Physics, 3/94
hep-ex@arXiv.org             High Energy Physics - Experiment, 4/94
acc-phys@arXiv.org           Accelerator Physics, 11/94
mtrl-th@arXiv.org            Materials Theory, 11/94
supr-con@arXiv.org           Superconductivity, 11/94
nucl-ex@arXiv.org            Nuclear Experiment, 12/94
quant-ph@arXiv.org           Quantum Physics, 12/94
atom-ph@arXiv.org            Atomic, Molecular and Optical Physics, 9/95
plasm-ph@arXiv.org           Plasma Physics, 9/95
physics@arXiv.org            Physics, 10/96

Mathematics
alg-geom@arXiv.org           Algebraic Geometry, 2/92
funct-an@arXiv.org           Functional Analysis, 4/92
dg-ga@arXiv.org              Differential Geometry, 6/94
q-alg@qrXiv.org              Quantum Algebra and Topology, 12/94

Other
nlin-sys@arXiv.org           Nonlinear Sciences, 1/93
cmp-lg@arXiv.org             Computation and Language, 4/94
ao-sci@arXiv.org             Atmospheric-Oceanic Sciences, 2/95

---------------------------------------------------------------------
Disclaimer:
Problems printing a paper should be directed to its authors.
Papers will be entered in the listings in order of receipt on an impartial
basis and appearance of a paper is not intended in any way to convey
tacit approval of its assumptions, methods, or conclusions by any agent
(electronic, mechanical, or other).
We reserve the right to reject any inappropriate submissions.

This e-print archive should not be used to distribute non-technical information
(such as news or information about political causes of potential special
interest to the academic community). Finally, this is an e-print archive.
Submissions of an abstract without a paper will be rejected outright.
